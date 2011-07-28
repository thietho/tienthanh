

<style>
.tb-tree{}
.tb-tree input{margin-right:3px;}
.tb-tree label{font-size:0.9em}
#result div img{vertical-align:middle;margin-bottom:2px;}
.tb-tree .td-selected{}
.td-selected #selected img{vertical-align:top;margin-bottom:2px;}

</style>


<form id="ffile" name="ffile" method="post">

<table width="100%" class="data-table">
	<tr>
        <td colspan="3">
     		<input type="hidden" name="sitemap" id="sitemap" value="" />
      		<strong>Keyword</strong> <input type="text" name="keyword" id="keyword" class="text" />&nbsp;&nbsp;
            
            
            			
            
            &nbsp;&nbsp;<input type="button" id="btnfilter" name="btnfilter" value="Filter" class="button"/>
            
        </td>
    </tr>
    <tr>
    	<td colspan="3">
        	<p id="pnImage">
                <label for="image">Upload file</label><br />
                <a id="btnAddImagePopup" class="button">Select file</a><br />
                <!--<img id="preview" src="<?php echo $imagethumbnail?>" />
                <input type="hidden" id="imagepath" name="imagepath" value="<?php echo $imagepath?>" />
                <input type="hidden" id="imageid" name="imageid" value="<?php echo $imageid?>" />
                <input type="hidden" id="imagethumbnail" name="imagethumbnail" value="<?php echo $imagethumbnail?>" />-->
                <div id="errorupload" class="error" style="display:none"></div>
            </p>
        </td>
    </tr>
    <tr valign="top">
    	<td width="34%" class="tb-tree">
        	<?php echo $sitemap?>
        </td>
        <td width="40%" id="result" style="vertical-align:top !important">
        	Loading...
        </td>
        <td width="26%" style="vertical-align:top !important" class="td-selected">
        	<div id="selected">
            </div><br />

            <input type="button" class="button" name="btnSelect" value="OK" onclick="saveSelect()"/>
        </td>
    </tr>
</table>
</form>
<script>
	var imageindex = 0;
	var DIR_UPLOADPHOTO = "<?php echo $DIR_UPLOADPHOTO?>";
	var DIR_UPLOADATTACHMENT = "<?php echo $DIR_UPLOADATTACHMENT?>";
</script>
<script language="javascript">
//alert(parent.opener.document.InsertContent.title.value);
$(document).ready(function() {
  	$("#result").load("?route=core/file/getList");
	
	$(".checkbox").click(function(index){
		//alert($(this).val());
		//alert(this.checked);
		
		temp ="";
		$(".checkbox").each(function(index){
			
			if(this.checked)
			temp += $(this).val()+",";
		})
		$("#sitemap").val(temp);
	});
});

$("#btnfilter").click(function(){
	
	url = "?route=core/file/getList&keyword="+escape($("#keyword").val())+"&location="+$("#location").val()+"&sitemap="+$("#sitemap").val();
	$("#result").load(url);						   
})

function moveto(url)
{
	$("#result").html("Loading...")
	$("#result").load(url);	
}
function removeFile(fileid)
{
	$("#rowimage"+fileid).html("");	
	//arr.splice(arr.indexOf(fileid),1,arr);
}
var arr = new Array();
function selectFile(fileid)
{
	if(arr.indexOf(fileid)==-1)
	{
		arr.push(fileid);
	
		input = '<input type="hidden" class="rows" id="seletediamge'+fileid+'" name="seletediamge'+fileid+'" value="'+fileid+'" />';
		remove = '<a class="button" onClick="removeFile('+ fileid +')">Remove</a>'
		$("#selected").append("<div id='rowimage"+fileid+"'>"+$("#image"+fileid).html()+input+"</div>"+remove+"<br/>");
	}
}

function saveSelect()
{
	//parent.opener.document.InsertContent.listselectfile.value ="";
	$("#listselectfile").val('');
	$(".rows").each(function(index){
		//parent.opener.document.InsertContent.listselectfile.value+=$(this).val()+",";
		$("#listselectfile").val($("#listselectfile").val()+$(this).val()+",")
	})
	//window.close();
	$.unblockUI();
	addImageToDescription();
}

function callbackUploadFile()
{
	new AjaxUpload(jQuery('#btnAddImagePopup'), {
		action: DIR_UPLOADATTACHMENT,
		name: 'image2',
		responseType: 'json',
		onChange: function(file, ext){
		},
		onSubmit: function(file, ext){
			$('.loadingimage').show();
			// Allow only images. You should add security check on the server-side.
			/*if (ext && /^(jpg|png|jpeg|gif)$/i.test(ext)) {                            
				$('#pnImage').hide();
				$('.loadingimage').show();
			} else {
				alert('Your selection is not image');
				return false;
			}        */                    
		},
		onComplete: function(file, response){
			//alert(response);
			if(response.files.error == 'none')
			{
				$('#errorupload').hide();
				$("#result").load("?route=core/file/getList");
				//$('input#attimageid'+imageindex).val(response.files.imageid);
				//$('#attachment').append()
				/*$('input#imagepath').val(response.files.imagepath);
				$('input#imagethumbnail').val(response.files.imagethumbnail);
				$('#preview').attr("src", response.files.imagethumbnail);
				$('#errorupload').hide();*/
				
				
			}
			else
			{
				$('#errorupload').html(response.files.error);
				$('#errorupload').show();
			}
			$('#pnImage').show();
			$('.loadingimage').hide();
			
		}
	});	

	
}
callbackUploadFile();
</script>