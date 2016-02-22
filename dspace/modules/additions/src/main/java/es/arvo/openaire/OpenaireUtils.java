package es.arvo.openaire;

import java.sql.SQLException;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.dspace.content.Collection;
import org.dspace.content.Item;
import org.dspace.core.ConfigurationManager;
import org.dspace.core.Context;
import org.dspace.eperson.EPerson;
import org.dspace.eperson.Group;

public class OpenaireUtils {
    private static final Logger log = Logger.getLogger(OpenaireUtils.class);
    
    /*
     * Función que determina si un usuario pertenece a un grupo 
     */
    public static boolean isRegistered(String id) {
    	boolean result=false;
    	Context context=null;
    	if (id != "[]" && id != "") {
    		String groupName = ConfigurationManager.getProperty("dspace.disqus.group");
    		try {
    			context = new Context();
    			Group group = Group.findByName(context, groupName);
    			if (group != null) {
    				EPerson e = EPerson.find(context, Integer.parseInt(id));
    				result= group.isMember(e);
    			} 
    		} catch (SQLException e1) {
    			log.warn("Error en isRegistered",e1);
    			e1.printStackTrace();
    		}finally{
    			if(context!=null){
    	    		context.abort();
    	    	}
    		}
    	} 
    	return result;
    }
    public static boolean isRevision(int itemId) {
    	boolean isRevision=false;
    	
    		String colectionRevisiones = ConfigurationManager.getProperty("openaire.coleccion.evaluaciones");
    		Context context=null;
    		try{
    			context = new Context();
    			Item item=Item.find(context,itemId);
    			Collection[] colecciones=item.getCollections();
    			for(int i=0;i<colecciones.length;i++){
    				if (colecciones[i].getHandle().equalsIgnoreCase(colectionRevisiones)){
    					isRevision=true;
    					break;
    				}
    			}
    		} catch (SQLException e) {
    			log.error("Error comparando colecciones en XSLUtils.isRevision",e);
    			e.printStackTrace();
    		}finally{
    			if(context!=null){
    				context.abort();
    			}
    		}
    	return isRevision;
    }
    public static boolean isItem(int itemId) {
    	boolean isItem=true;
    		String colectionRevisiones = ConfigurationManager.getProperty("openaire.coleccion.evaluaciones");
    		String colectionJuicios = ConfigurationManager.getProperty("openaire.coleccion.juicios");
    		Context context=null;
    		try{
    			context = new Context();
    			Item item=Item.find(context, itemId);
    			Collection[] colecciones=item.getCollections();
    			for(int i=0;i<colecciones.length;i++){
    				if (colecciones[i].getHandle().equalsIgnoreCase(colectionRevisiones) || colecciones[i].getHandle().equalsIgnoreCase(colectionJuicios)){
    				    isItem=false;
    				    break;
    				}
    			}
    		} catch (SQLException e) {
    			log.error("Error comparando colecciones en XSLUtils.isItem",e);
    			e.printStackTrace();
    		}finally{
    			if(context!=null){
    				context.abort();
    			}
    		}
    	return isItem;
    }
}
