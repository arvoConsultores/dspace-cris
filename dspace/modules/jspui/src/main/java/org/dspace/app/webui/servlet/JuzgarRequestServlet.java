/**
 * The contents of this file are subject to the license and copyright
 * detailed in the LICENSE and NOTICE files at the root of the source
 * tree and available online at
 *
 * http://www.dspace.org/license/
 */
package org.dspace.app.webui.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.dspace.app.requestitem.RequestItem;
import org.dspace.app.webui.util.JSPManager;
import org.dspace.authorize.AuthorizeException;
import org.dspace.content.Bitstream;
import org.dspace.content.Bundle;
import org.dspace.content.DCValue;
import org.dspace.content.DSpaceObject;
import org.dspace.content.Item;
import org.dspace.content.RevisionToken;
import org.dspace.core.ConfigurationManager;
import org.dspace.core.Constants;
import org.dspace.core.Context;
import org.dspace.core.Email;
import org.dspace.core.I18nUtil;
import org.dspace.core.LogManager;
import org.dspace.core.Utils;
import org.dspace.eperson.EPerson;
import org.dspace.handle.HandleManager;
import org.dspace.storage.bitstore.BitstreamStorageManager;

/**
 * 
 * 
 * @author Adán Roman Ruiz at arvo.es
 * @version $Revision$
 */
public class JuzgarRequestServlet extends DSpaceServlet
{
    /** Logger */
    private static Logger log = Logger.getLogger(JuzgarRequestServlet.class);
    public static String MESSAGE_REQUEST_COPY="juicio de revision";
    
    protected void doDSGet(Context context, HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException,
            SQLException, AuthorizeException
    {

        log.info(LogManager.getHeader(context, "juicio_revision_request", ""));

        JSPManager.showJSP(request, response, "/openaire/juicioRequest.jsp");
    }

    protected void doDSPost(Context context, HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException,
            SQLException, AuthorizeException
    {
	 String email = request.getParameter("email");
	 String handle = request.getParameter("handle");
	 
	 boolean ok=false;
	 // Comprobar que el email es correcto
	 boolean mailCorrecto=comprobarMailCorrecto(email);
	 // Comprobar que ese email puede emitir juicios
	 boolean mailpermitido=comprobarMailPuedeEmitirJuicios(email,handle,context);
	 
	 if(StringUtils.isEmpty(email)){
	     request.setAttribute("missing.fields", Boolean.TRUE);
	 }else if(!mailCorrecto){
	     request.setAttribute("mail.incorrecto", Boolean.TRUE);
	 }else if(!mailpermitido){
	     request.setAttribute("mail.prohibido", Boolean.TRUE);
	 }else{
	     ok=true;
	 }
	

        if (ok)
        {
         
            // Enviar el correo con token de juicio
            DSpaceObject dso=HandleManager.resolveToObject(context, handle);
            if(dso.getType()!=org.dspace.core.Constants.ITEM){
                //ERROR
        	log.error("Error Deberia ser un item");
            }
            Item item=(Item) dso;
            RequestItem ri=new RequestItem(item.getID(), -1, email,email, MESSAGE_REQUEST_COPY, true);
            log.info("Enviando mail a "+ri.getReqEmail());
            try {
		processSendDocuments(context,ri,item,getTitle(item));
	    } catch (MessagingException e) {
		log.error("Error enviando mail en JuicioRequestServlet",e);
		e.printStackTrace();
	    }
            log.info("Mail enviado");
            context.commit();
           
            // Show confirmation
            //request.setAttribute("password.updated", Boolean.valueOf(settingPassword));
            JSPManager.showJSP(request, response,"/openaire/juicioRequest-sent.jsp");

            context.complete();
        }
        else
        {
            log.info(LogManager.getHeader(context, "juicio_request",
                    "problem=true"));

//            request.setAttribute("eperson", eperson);

            JSPManager.showJSP(request, response, "/openaire/juicioRequest.jsp");
        }
    }
    // Solo pueden hacer juicios los que tengan revisiones de ese mismo item
    private boolean comprobarMailPuedeEmitirJuicios(String email, String handle, Context context) throws IOException, SQLException, AuthorizeException {
	if(StringUtils.isNotBlank(handle) && StringUtils.isNotBlank(email)){
	    DSpaceObject dso=HandleManager.resolveToObject(context, handle);
	    RevisionToken revisionToken=RevisionToken.findItemOfRevision(context, dso.getID());
	    ArrayList<RevisionToken> revisiones=RevisionToken.findRevisionsOfHandle(context, revisionToken.getHandleRevisado());
	    for(int i=0;i<revisiones.size();i++){
		if(revisiones.get(i).getEmail().equalsIgnoreCase(email)){
		    return true;
		}
	    }
	}
	return false;
    }
    private static boolean comprobarMailCorrecto(String email) {
   	//Vacio es correcto
   	if(StringUtils.isEmpty(email)){
   	    return true;
   	}
   	String PATTERN_EMAIL = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
   	Pattern pattern = Pattern.compile(PATTERN_EMAIL);
   	Matcher matcher = pattern.matcher(email);
   	if(matcher.matches()){
   	    return true;
   	}
   	return false;
       }
    private String getTitle(Item item) {
    	DCValue[] title = item.getMetadata("dc","title",null,Item.ANY);
    	if(title!=null && title.length>0){
    		return title[0].value;
    	}
    	return "Sin titulo";
    }
 // Copia de ItemRequestResponseAction
    private void processSendDocuments(Context context, RequestItem requestItem,Item item,String title) throws SQLException, MessagingException, IOException, AuthorizeException {
	String token=Utils.generateHexKey();
	String url=generateUrl(token);
    	Email email=Email.getEmail( I18nUtil.getEmailFilename(context.getCurrentLocale(), "enviarTokenJuicio"));
       	email.addRecipient(requestItem.getReqEmail());
        email.addArgument(getTitle(item));//{1}
        email.addArgument(getAuthors(item));//{2}
        email.addArgument(item.getHandle());//{3}
        email.addArgument(url);//{4}
        email.addArgument("");//{5}
        email.addArgument(ConfigurationManager.getProperty("mail.feedback.recipient"));//{6}
        if (requestItem.isAllfiles()){
            Bundle[] bundles = item.getBundles("ORIGINAL");
            for (int i = 0; i < bundles.length; i++){
                Bitstream[] bitstreams = bundles[i].getBitstreams();
                for (int k = 0; k < bitstreams.length; k++){
                    if (!bitstreams[k].getFormat().isInternal() /*&& RequestItemManager.isRestricted(context, bitstreams[k])*/){
                        email.addAttachment(BitstreamStorageManager.retrieve(context, bitstreams[k].getID()), bitstreams[k].getName(), bitstreams[k].getFormat().getMIMEType());
                    }
                }
            }
        } else {
            Bitstream bit = Bitstream.find(context,requestItem.getBitstreamId());
            email.addAttachment(BitstreamStorageManager.retrieve(context, requestItem.getBitstreamId()), bit.getName(), bit.getFormat().getMIMEType());
        }     
        
        email.send();
        
        RevisionToken rt=new RevisionToken(requestItem.getReqEmail(),"J",token,item.getHandle());
        rt.create(context);

        requestItem.setDecision_date(new Date());
        requestItem.setAccept_request(true);
        requestItem.update(context);
	}
    private String getAuthors(Item item) {
    	DCValue[] author = item.getMetadata("dc","contributor","author",Item.ANY);
    	if(author!=null && author.length>0){
    		StringBuffer sb=new StringBuffer();
    		for(int i=0;i<author.length;i++){
    			if(i!=0){
    				sb.append("; ");
    			}
    			sb.append(author[i].value);
    		}
    		return sb.toString();
    	}
    	return "Sin autor indicado";
	}
    
    private String generateUrl(String token) {
   	StringBuffer sb=new StringBuffer();
   	sb.append(ConfigurationManager.getProperty("dspace.url"));
//   	sb.append("/handle/");
//   	sb.append(ConfigurationManager.getProperty("openaire.coleccion.evaluaciones"));
//   	sb.append("/submit?tokenEvaluacion=");
   	sb.append("/submit?tokenEvaluacion=");
   	sb.append(token);
   	//sb.append("/revision");
   	return sb.toString();
       }
}
