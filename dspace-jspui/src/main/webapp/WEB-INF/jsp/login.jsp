<%@ include file="/common/taglib.jsp"%>
<form name="f" action="/jspui/login.htm" method="post">               
    <fieldset>
        <legend>Please Login</legend>
        <label for="username">Username</label>
        <input type="text" id="username" name="username"/>        
        <label for="password">Password</label>
        <input type="password" id="password" name="password"/>    
        <div class="form-actions">
            <button type="submit" class="btn">Log in</button>
        </div>
    </fieldset>
</form>