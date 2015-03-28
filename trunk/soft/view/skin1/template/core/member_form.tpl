
<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $heading_title?>User</div>
    
    <div class="section-content padding1">
    
    	<form id="frm" name="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	
     	        <input type="hidden" name="id" value="<?php echo $user['id']?>" />   
                <input type="hidden" name="usertypeid" value="member" />   
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	
                
                
                <p>
            		<label>Full name</label><br />
					<input type="text" name="fullname" value="<?php echo $user['fullname']?>" class="text" size=60 autocomplete="on" />
                    
            	</p>
                <p>
            		<label>Birthday</label><br />
<script language="javascript">
 	$(function() {
		$("#birthday").datepicker({
				changeMonth: true,
				changeYear: true,
				dateFormat: 'dd-mm-yy'
				});
		});
 </script>
					<input type="text" id="birthday" name="birthday" value="<?php echo $this->date->formatMySQLDate($user['birthday'])?>" class="text" size=60/>
                    
            	</p>
                <p>
            		<label>Email</label><br />
					<input type="text" name="email" value="<?php echo $user['email']?>" class="text" size=60 />
                    
            	</p>
                <p>
            		<label>Phone</label><br />
					<input type="text" name="phone" value="<?php echo $user['phone']?>" class="text" size=60 />
                    
            	</p>
                <p>
            		<label>Address</label><br />
					<input type="text" name="address" value="<?php echo $user['address']?>" class="text" size=60 />
            	</p>
                <p>
                	<label>Assign</label><br />
					<input type="hidden" id="assignid" name="assignid" value="<?php echo $user['assignid']?>"/>
                    <input type="text" id="assignname" name="assignname" value="<?php echo $this->document->getCustomer($user['assignid'])?>" class="text" size=60 />
                    <input type="button" class="button" id="btnRemoveAssign" value="Remove Assign">
                </p>
                <p>
            		<label>Commissions</label><br />
					<input type="text" id="commissions" name="commissions" value="<?php echo $user['commissions']?>" class="text number"/>%
            	</p>
                <p>
            		<label>Avatar</label><br />
					<p id="pnImage">
                        <label for="image"><?php echo $entry_image?></label><br />
                        <a id="btnAddImage" class="button">Select photo</a><br />
                        <img id="preview" src="<?php echo $user['imagethumbnail']?>" />
                        <input type="hidden" id="imagepath" name="imagepath" value="<?php echo $user['imagepath']?>" />
                        <input type="hidden" id="imageid" name="imageid" value="<?php echo $user['imageid']?><?php echo $imageid?>" />
                        <input type="hidden" id="imagethumbnail" name="imagethumbnail" value="<?php echo $user['imagethumbnail']?>" />
                    </p>
                        
                        
                    <div id="errorupload" class="error" style="display:none"></div>
                    
                    <div class="loadingimage" style="display:none"></div>
            	</p>
            </div>
            
        </form>
    
    </div>
    
</div>
<script language="javascript">
$('#btnRemoveAssign').click(function(e) {
    $('#assignid').val('');
	$('#assignname').val('');
	$('#commissions').val(0);
});
$(document).ready(function(e) {
	numberReady();
	$(function() {
		var cache = {};
		
		$("#assignname").autocomplete({
			minLength: 2,
			select: function( event, ui ) {
				//console.log(ui.item.id);
				//objdl.getProbyMediaId(ui.item.id);
				//alert(ui.item.data.fullname);
				$('#assignid').val(ui.item.id);
				$('#assignname').val(ui.item.data.fullname);
				
			},
			source: function( request, response ) {
			var term = request.term;
			if ( term in cache ) {
				response( cache[ term ] );
				return;
			}
			$.getJSON( "?route=core/member/getMember", request, function( data, status, xhr ) {
				cache[ term ] = data;
				response( data );
				});
			}
		});
		
	});
    
});
</script>
