<style>
.progress
{
	width:100%;	
	
}
.bar {
    height: 18px;
    background: green;
	text-align:center;
}
</style>



<div id="frmfile">
<table width="100%" class="data-table">
	<tr>
        <td colspan="3">
        	
      		<strong>File name</strong> <input type="text" name="keyword" id="keyword" class="text" />&nbsp;&nbsp;
            
            
            			
            
           
            
            <div class="progress" id="progress'+t+'"><div class="bar" style="width: 0%;"></div></div>
            <table>
                <tbody id="listfile">
                </tbody>
            </table>
        </td>
    </tr>
    <tr>
    	<td colspan="3">
        	<p id="pnImage">
                
                
                <input id="fileupload" class="button" type="file" name="files[]"  multiple value="Chon file" >
               	
                <br />
                <div id="errorupload" class="error" style="display:none"></div>
               
                <?php if($_GET['dialog'] == ''){?>
                
                <?php } ?>
                
            </p>
        </td>
    </tr>
    <tr valign="top">
    	
        <td style="vertical-align:top !important">
        	
        	
            <div id="pathview"></div>
        	<div id="result"></div>
        	
        </td>
        
    </tr>
</table>
</div>
<script>
	var imageindex = 0;
	var DIR_UPLOADPHOTO = "<?php echo $DIR_UPLOADPHOTO?>";
	var DIR_UPLOADATTACHMENT = "<?php echo $DIR_UPLOADATTACHMENT?>";
var cur = "";
var posk =0

$(function () {
    $('#fileupload').fileupload({
        dataType: 'json',
		/*add: function (e, data) {
			//alert(data.files[0].name)
			var t =posk++;
			
			var str = '<tr>';
			str += '<td>'+data.files[0].name+'</td>';
			str += '<td id="btn'+t+'"></td>';
			str += '<td><div class="progress" id="progress'+t+'"><div class="bar" style="width: 0%;"></div></div></td>';
			str += '</tr>'
			$('#listfile').append(str);
            data.context = $('<button class="btnUpload" id="up'+t+'" ref="'+t+'"/>').text('Upload')
                .appendTo($('#btn'+t))
                .click(function () {
					cur = t;
                    data.context = $('<p/>').text('Uploading...').replaceAll($(this));
                    data.submit();
                });
        },*/
        done: function (e, data) {
            /*$.each(data.result.files, function (index, file) {
                $('<p/>').text(file.name).appendTo(document.body);
            });*/
			/*var fileid = response.files[i].imageid;
				var folderid = $('#folderidcur').val();
			$.get("?route=core/file/updateFolder&fileid="+fileid+"&folderid="+folderid,
				function(){
					 file.showList("?route=core/file/getList&folderid="+folderid);
				});*/
			
			file.showList("?route=core/file/getList&folder="+ encodeURI($('#pathview').html()));
        },
		progressall: function (e, data) {
			//showProgress(cur,e, data)
			var progress = parseInt(data.loaded / data.total * 100, 10);
			$('.bar').html(progress+"%");
			$('.progress .bar').css(
				'width',
				progress + '%'
			);
		}
    });
});
function showProgress(id,e, data)
{
	var progress = parseInt(data.loaded / data.total * 100, 10);
	$('#progress'+cur+' .bar').css(
				'width',
				progress + '%'
	);
}
</script>
<script language="javascript">
function ObjFile()
{
	this.path = Array();
	this.clipboard = Array();
	this.iscut = false;
	//this.clipboard.length
	this.selectFolder = function(folder)
	{
		if(folder=="..")
		{
			this.path.pop();	
		}
		else
			this.path.push(folder);
		
		file.showList("?route=core/file/getList&folder="+ encodeURI(this.path.join("/")));
		console.log(this.path.join("/"));
		this.showPath();
	}
	this.showPath = function()
	{
		$('#pathview').html(this.path.join("/"));	
	}
	this.copy = function()
	{
		$.post("?route=core/file/copy",
			{
				source:this.clipboard,
				desdir:this.path.join("/")
			},
			function(data){
				file.showList("?route=core/file/getList&folder="+ encodeURI(file.path.join("/")));
				if(file.iscut == true)
				{
					$.post("?route=core/file/delListFile",
								{
									chkfile:file.clipboard
								});
					file.iscut = false;
				}
				file.clipboard = Array();
				//console.log("clipboard: "+ file.clipboard);
		});	
	}
	
	this.del = function()
	{
		var ans = confirm("Bạn có chắc xóa file không?");
		if(ans == true)
		{
			var arrpath = Array();
			
			$('.selectfile').each(function(index, element) {
				var filepath = $(this).attr("filepath");
				arrpath.push(filepath);
			});
			$.post("?route=core/file/delListFile",
				{
					chkfile:arrpath
				},
				function(data){
					file.showList("?route=core/file/getList&folder="+ encodeURI(file.path.join("/")));
			});	
			
		}
	}
	this.show = function(filepath)
	{
		$('body').append('<div id="fileinfor" style="display:none"></div>');
		var eid = "#fileinfor";
		$(eid).attr('title','Thông tin file');
			$(eid).dialog({
				autoOpen: false,
				show: "blind",
				hide: "explode",
				width: $(document).width()-100,
				height: window.innerHeight,
				close:function()
				{
					$(eid).remove();
				},
				modal: true,
				buttons: {
					'Các bài viết sử dụng':function()
					{
						showMediaUse(fileid);
					},
					'Đưa vào bài viết':function()
					{
						showMediaForm(fileid);
					},
					'Tải về':function()
					{
						window.location = "download.php?url="+ encodeURI($('#filepath').val());
					},
					'Đóng': function() 
					{
						
						$( eid ).dialog( "close" );
					},
				}
			});
		
			$(eid).dialog("open");
			$(eid).html(loading);
			$(eid).load("?route=core/file/detail&filepath="+encodeURI(filepath)+"&dialog=true",function(){
				
		});
	}
	this.newFolder = function()
	{
		$('body').append('<div id="frmnewfolder" style="display:none"></div>');
		var eid = "#frmnewfolder";
		$(eid).attr('title','Tạo thư mục');
			$(eid).dialog({
				autoOpen: false,
				show: "blind",
				hide: "explode",
				width: 200,
				height: 150,
				modal: true,
				close:function()
				{
					$(eid).remove();
				},
				buttons: {
					
					
					'Tạo':function()
					{
						flag = true;
						console.log("Dir name: "+ $('#txt_dirname').val());
						if($('#txt_dirname').val()=="")
						{
							alert("Bạn chưa nhập tên thư mục");	
							flag = false;
						}
						$('.folderlist').each(function(index, element) {
                            if($('#txt_dirname').val() == $(this).attr('folderpath'))
							{
								alert("Tên thư mục đã tồn tại");
								flag = false;
							}
                        });
						if(flag)
						{
							console.log("Thu muc hop le");
							$.post("?route=core/file/newFolder",
								{
									foldername:	$('#txt_dirname').val(),
									desdir:file.path.join("/")
								},
								function(){
									file.showList("?route=core/file/getList&folder="+ encodeURI(file.path.join("/")));
									$( eid ).dialog( "close" );
								}
							);
						}
					},
					'Đóng': function() 
					{
						
						$( eid ).dialog( "close" );
					},
				}
			});
		
			$(eid).dialog("open");
			$(eid).html('<input type="text" class="text" id="txt_dirname" value=""/>');
			
	}
	this.rename = function(objfile)
	{
		$('body').append('<div id="frmnewfolder" style="display:none"></div>');
		var eid = "#frmnewfolder";
		$(eid).attr('title','Đổi tên');
			$(eid).dialog({
				autoOpen: false,
				show: "blind",
				hide: "explode",
				width: 200,
				height: 150,
				modal: true,
				close:function()
				{
					$(eid).remove();
				},
				buttons: {
					
					
					'Sửa':function()
					{
						flag = true;
						console.log("File name: "+ $('#txt_newname').val());
						if($('#txt_dirname').val()=="")
						{
							alert("Bạn chưa nhập tên thư mục");	
							flag = false;
						}
						if(objfile.hasClass('fileitem'))
						{
							$('.fileitem').each(function(index, element) {
								if($('#txt_newname').val() == $(this).attr('filename') )
								{
									alert("Tên file đã tồn tại");
									flag = false;
								}
							});
														
						}
						if(objfile.hasClass('folderitem'))
						{
							$('.folderitem').each(function(index, element) {
								if($('#txt_newname').val() == $(this).attr('filename') )
								{
									alert("Tên thư mục đã tồn tại");
									flag = false;
								}
							});
							
						}
						if(flag)
						{
							console.log("File hop le");
							$.post("?route=core/file/rename",
								{
									oldname:objfile.attr('filepath'),
									newname:$('#txt_newname').val()
								},
								function(){
									file.showList("?route=core/file/getList&folder="+ encodeURI(file.path.join("/")));
									$( eid ).dialog( "close" );
								}
							);
						}
					},
					'Đóng': function() 
					{
						
						$( eid ).dialog( "close" );
					},
				}
			});
		
			$(eid).dialog("open");
			$(eid).html('<input type="text" class="text" id="txt_newname" value="'+ objfile.attr('filename') +'"/>');
	}
	this.showList = function(url)
	{
		$.xhrPool.abortAll();
		$.xhrPool = [];
			$.xhrPool.abortAll = function() {
				$(this).each(function(idx, jqXHR) {
					jqXHR.abort();
				});
				$.xhrPool = [];
			};
		$('#pathview').html(file.path.join("/"));
		$('#result').html(loading);
		$("#result").load(url,function(){
			if("<?php echo $_GET['dialog']?>" =='true')
				intSeleteFile("<?php echo $_GET['type']?>");
				$('#fileupload').fileupload({
					// Uncomment the following to send cross-domain cookies:
					//xhrFields: {withCredentials: true},
					url: '?route=common/uploadfile&folder=' + encodeURI(file.path.join("/"))
				});
			//
			$('.filelist').dblclick(function(e) {
				
			});
			$('.filelist').click(function(e) {
				if($(this).hasClass('selectfile'))
					$(this).removeClass('selectfile');
				else
					$(this).addClass('selectfile');
			});
			$('.filelist').hover(
				function(){
					$(this).css('background-color','#ccc');
					
				},
				function(){
					$(this).css('background-color','transparent');
					//$(this).children('.filename').css('overflow','hidden');
				});
				
			$('.folderlist').dblclick(function(e) {
				var folder = $(this).attr('folderpath');
				file.selectFolder(folder);
			});
			$('.folderlist').click(function(e) {
				if($(this).hasClass('selectfolder'))
					$(this).removeClass('selectfolder');
				else
					$(this).addClass('selectfolder');
			});
			
		});
	}
}
/*function loadFolder()
{
	
	$('#showfolder').load("?route=core/file/getFolderTreeView",function(){
		var CLASSES = ($.treeview.classes = {
			animated: "fast",
 			collapsed: false,
			persist: "cookie",
 			cookieId: "rememberme"
		});
		$("#group0").treeview(CLASSES);
		intFolder()
	});
}
function intFolder()
{
	$('.folderitem').click(function(e) {
		$('.folderitem').removeClass("selectfolder");
		$(this).addClass("selectfolder");
		var folderid = $(this).attr('folderid');
		selectFolder(folderid)
	});
}*/

var arrfileid = new Array();
$("#frmfile #keyword").keyup(function(e){
	//if(e.keyCode == 13)
	{
		
		url = "?route=core/file/getList&folder="+ encodeURI(file.path.join("/"))+"&keyword="+encodeURI($("#frmfile #keyword").val());
		file.showList(url);
							   
	}
})

var file = new ObjFile();
$(document).ready(function() {
  	file.showList("?route=core/file/getList");
});




//callbackUploadFile();
</script>
