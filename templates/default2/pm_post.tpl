{IF PREVIEW}
  <div class="PhorumStdBlockHeader PhorumHeaderText" style="text-align: left;">{LANG->Preview}</div>
  <div class="PhorumStdBlock" style="text-align: left;">
    <div class="PhorumReadBodySubject">{PREVIEW->subject}</div>
    <div class="PhorumReadBodyHead">{LANG->From}: <strong><a href="#">{PREVIEW->from_username}</a></strong></div>
    <div class="PhorumReadBodyHead">
      {LANG->To}:
      {VAR ISFIRST true}
      {LOOP PREVIEW->recipients}
        <div style="display:inline; white-space: nowrap">
          {IF NOT ISFIRST} / {/IF}
          <strong><a href="#">{PREVIEW->recipients->username}</a></strong>
          {VAR ISFIRST false}
        </div>
      {/LOOP PREVIEW->recipients}
    </div><br />
    <div class="PhorumReadBodyText">{PREVIEW->message}</div><br />
  </div><br />
{/IF}


<form action="{URL->ACTION}" method="post">
    {POST_VARS}
    <input type="hidden" name="action" value="post" />
    <input type="hidden" name="forum_id" value="{FORUM_ID}" />
    <input type="hidden" name="hide_userselect" value="{HIDE_USERSELECT}" />

    <div class="generic">
    
        <small>
    
            To:<br />
            {! Show user selection}
            {IF SHOW_USERSELECTION}
                <div class="phorum-pmuserselection">
                    {IF USERS}
                        <select id="userselection" name="to_id" size="1" align="middle">
                            <option value=""> {LANG->PMSelectARecipient}</option>
                            {LOOP USERS}
                                <option value="{USERS->user_id}" <?php if (isset($_POST['to_id']) && $_POST['to_id'] == $PHORUM['TMP']['USERS']['user_id']) echo 'selected="selected"'?>>{USERS->displayname}</option>
                            {/LOOP USERS}
                        </select>
                    {ELSE}
                        <input type="text" id="userselection" name="to_name" value="<?php if (isset($_POST['to_name'])) echo htmlspecialchars($_POST['to_name'])?>" />
                    {/IF}
                    <input type="submit" style="font-size: {smallfontsize}" name="rcpt_add" value="{LANG->PMAddRecipient}" />
                    {! Always show recipient list on a separate line}
                    {IF RECIPIENT_COUNT}<br style="clear:both" />{/IF}
                </div>
            {/IF}
            {! Display the current list of recipients}
            {LOOP MESSAGE->recipients}
                <div class="phorum-recipientblock">
                    {MESSAGE->recipients->username}
                    <input type="hidden" name="recipients[{MESSAGE->recipients->user_id}]" value="{MESSAGE->recipients->username}" />
                    <input type="image" src="{URL->TEMPLATE}/images/delete.png" name="del_rcpt::{MESSAGE->recipients->user_id}" class="rcpt-delete-img" title="" />
                </div>
            {/LOOP MESSAGE->recipients}
            <br />
                
            {LANG->Subject}:<br />
            <input type="text" name="subject" id="subject" size="50" value="{MESSAGE->subject}" /><br />
            <br />
    
            {LANG->Options}:<br />
            <input type="checkbox" name="keep" value="1"{IF MESSAGE->keep} checked="checked" {/IF} /> {LANG->KeepCopy}<br />
            <br />
    
                
            {LANG->Message}:
            <div id="post-body">
                <textarea name="message" id="body" class="body" rows="15" cols="50">{MESSAGE->message}</textarea>
            </div>
        
        </small>
        
    </div>
        
    <div id="post-buttons">
    
        {HOOK "tpl_editor_buttons"}
        
      <input name="preview" type="submit" value=" {LANG->Preview} " />
      <input type="submit" value=" {LANG->Post} " />
        
    </div>
        
</form>

