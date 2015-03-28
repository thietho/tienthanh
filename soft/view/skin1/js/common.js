// JavaScript Document
function confirm_check(url,mess)
{
	anser=confirm(mess)
	
	if(anser==true)
		window.location = url
}
function linkto(url)
{
	window.location = url
}
function moveto(url,eid)
{
	$("#"+eid).html(loading);
	$("#"+eid).load(url);	
}
function searchMatrix(matrix,col,need)
{
	for(i=0;i < matrix.length ;i++)
		if(matrix[i][col]==need)
			return i
	return -1
}
function getPosOfNode(idparent,eid)
{
	var e = document.getElementById(idparent);
	i=0
	chi=e.childNodes[i]
	while(chi)
	{
		if(chi.id == eid)
			return i
		
		i++
		chi=e.childNodes[i]
	}
	return -1
}

function setCKEditorType(strID, intType)
{
	obj = CKEDITOR.instances[strID]
	if (obj) {
		//console.log(obj)
		CKEDITOR.remove(obj);
		
	}
	switch (intType)
	{
		case 0: // giao dien full
		CKEDITOR.replace( strID,
				{
					toolbar : [ ['Source','-','Save','NewPage','Preview','-','Templates'],['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print','SpellChecker','Scayt'],['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],['Form','Checkbox','Radio','TextField','Textarea','Select','Button','ImageButton','HiddenField'],'/',['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],['Link','Unlink','Anchor'],['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],'/',['Styles','Format','Font','FontSize'],['TextColor','BGColor'],['Maximize','ShowBlocks','-','About'] ]
				});
		//CKEDITOR.config.contentsCss = ['../view/skin1/css/ckeditor.css'];
		CKEDITOR.config.height = '400px';
		CKEDITOR.config.width = '640px';
		break;
		
		case 1: //Giao dien simply nhat
		CKEDITOR.replace( strID,
				{
					toolbar : [ ['Bold','Italic','Underline'],['Font','FontSize','TextColor','BGColor'],['Smiley'],['Link','Unlink'],['NumberedList','BulletedList'],['Outdent','Indent'],['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],['RemoveFormat'],['Maximize'] ]
				});
		//CKEDITOR.config.contentsCss = ['../view/skin1/css/ckeditor.css'];
		//CKEDITOR.config.height = '400px';
		//CKEDITOR.config.width = '640px';
		break;
		
		case 2: //giao dien edit content
		CKEDITOR.replace( strID,
				{
					toolbar : [ ['Source','Bold','Italic','Underline'],['Font','FontSize','TextColor','BGColor'],['Smiley'],['Link','Unlink'],['NumberedList','BulletedList'],['Outdent','Indent'],['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],['RemoveFormat'],['Maximize'],['PasteText','PasteFromWord'],['Flash','Table','SpecialChar'] ]
				});
		//CKEDITOR.config.contentsCss = ['../view/skin1/css/ckeditor.css'];
		CKEDITOR.config.height = '400px';
		CKEDITOR.config.width = '640px';
		break;
		
		case 3:
		CKEDITOR.replace( strID,
				{
					toolbar : [ ['Source','-','Save','NewPage','Preview','-','Templates'],['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print','SpellChecker','Scayt'],['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],['Form','Checkbox','Radio','TextField','Textarea','Select','Button','ImageButton','HiddenField'],'/',['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],['Link','Unlink','Anchor'],['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],'/',['Styles','Format','Font','FontSize'],['TextColor','BGColor'],['Maximize','ShowBlocks','-','About'] ]
				});
		//CKEDITOR.config.contentsCss = ['../view/skin1/css/ckeditor.css'];
		CKEDITOR.config.height = '400px';
		CKEDITOR.config.width = '640px';
		break;
		case 4: //giao dien edit content
		CKEDITOR.replace( strID,
				{
					toolbar : [['Font'] ]
				});
		//CKEDITOR.config.contentsCss = ['../view/skin1/css/ckeditor.css'];
		CKEDITOR.config.height = '100px';
		CKEDITOR.config.width = '300px';
		break;
	}
	
	
}


function importJavaScript(jsFile) {
	
	var scriptElt = document.createElement('script');
	
	scriptElt.type = 'text/javascript';
	
	scriptElt.src = jsFile;
	
	document.getElementsByTagName('head')[0].appendChild(scriptElt);

}


function showPopup(popupid, width, height, overlayclose )
{
	$(document).ready(function() { 
		$.blockUI({ 
			message: $(popupid),
			css: { 
				top:  ($(window).height() - height) /2 + 'px', 
				left: ($(window).width() - width) /2 + 'px', 
				width: width+'px',
				height: height+'px'
			} 			
		});
		
		if(overlayclose != false)
		{
			$('.blockOverlay').attr('title','Click to close').click(function(){closePopup();});  
		}
	});	
}

function closePopup()
{
	$.unblockUI();	
	if (CKEDITOR.instances['editorPopup']) {
		CKEDITOR.instances.editorPopup.destroy();
	}
}

function loadPopup(id)
{
	$("#popupbody").load("index.php?route=core/fileadjust&id="+id);
	
	$.blockUI(
	{ 
		message: $('#popup'),
		css: { 
			top:  ($(window).height() - 500) /2 + 'px', 
			left: ($(window).width() - 600) /2 + 'px', 
			width: '700px',
			height: '500px'
			}
	});
}

function postStringData(object) {
	var str = "";
	$(object).each(function(){
		str += $(this).attr('name') + "=" + $(this).val() + "&";
	});
	return str;
}
var win;
function openDialog(url,width,height) {
    //var result = window.showModalDialog(url, "", "dialogWidth:"+width+"px; dialogHeight:"+height+"px;");
	win = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=0, left=0, width="+width+", height="+height);
}
function daysInMonth(month,year) 
{
	var m = [31,28,31,30,31,30,31,31,30,31,30,31];
	if (month != 2) return m[month - 1];
	if (year%4 != 0) return m[1];
	if (year%100 == 0 && year%400 != 0) return m[1];
	return m[1] + 1;
} 

function toMonth(month)
{
	if(month<10)
		return "0"+month;
	else
		return month;
}
function stringtoNumber(str)
{
	str = (""+str).replace(/,/g,"");
	var num = str*1;
	return num;
}
function formateNumber(num)
{
	if(num =="")
		return 0;
	
	num = String(num).replace(/,/g,"");
	num = Number(num);
	ar = (""+num).split("\.");
	div = ar[0];
	mod = ar[1];
	
	arr = new Array();
	block = "";
	
	for(i=div.length-1; i>=0 ; i--)
	{
		
		block = div[i] + block;
		
		if(block.length == 3)
		{
			arr.unshift(block);
			block ="";
		}
		
	}
	arr.unshift(block);
	
	divnum = arr.join(",");
	divnum = trim(divnum,",")
	divnum = divnum.replace("-,","-")
	if(mod == undefined)
		return divnum;
	else
		return divnum+"\."+mod;
}

function trim(str, chars) {
	return ltrim(rtrim(str, chars), chars);
}
 
function ltrim(str, chars) {
	chars = chars || "\\s";
	return str.replace(new RegExp("^[" + chars + "]+", "g"), "");
}
 
function rtrim(str, chars) {
	chars = chars || "\\s";
	return str.replace(new RegExp("[" + chars + "]+$", "g"), "");
}

function toBasicText(str)
{
	var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?"; 
	for (var i = 0; i < str.length; i++) 
	{ 
		if (iChars.indexOf(str.charAt(i)) != -1) 
		{ 
			
			str = str.replace(str.charAt(i),"");
		}
		//alert(str.charAt(i))
	}
	return str;
}

function getPrefix(letter,n)
{
	var s = "";
	for(i=0;i<n;i++)
	{
		s+=letter;	
	}
	return s;
}

function isNumber(char)
{
	if( char!=8 && char!=0 && (char<45 || char>57) )
	{
	//display error message
	//$("#errmsg").html("Digits Only").show().fadeOut("slow");
		return false;
	}
	else true
}
function getFileExt(filepath)
{
	arr = filepath.split("\.");
	return arr[arr.length-1];
}

function numberReady()
{
	$(".number").change(function (e)
	{
		num = formateNumber($(this).val().replace(/,/g,""));
		$(this).val(num)
	});
	$(".number").keypress(function (e)
	{
		
	  	return isNumber(e.which);
	});
	
	$('.number').focus(function(e) {
        if(this.value == 0)
			this.value = "";
    });
	$('.number').blur(function(e) {
        if(this.value == "")
			this.value = 0;
    });
	$(".ben-datepicker").datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'dd-mm-yy'
			});
	$(".number").each(function(index){
		//alert(formateNumber($(this).val()))
		$(this).val(formateNumber($(this).val()))
		
	});	
	
		
	
}
$(document).ready(function(){
	
	$(".error").each(function(index){
		if($(this).text() == "")
		{
			$(this).hide();	
		}
	});
	
	numberReady();
					   
});
function printObject(o) {
  var out = '';
  for (var p in o) {
    out += p + ': ' + o[p] + '\n';
  }
  alert(out);
}
function logout()
{
	$.blockUI({ message: "<h1><?php echo $announ_infor ?></h1>" }); 
	
	$.get(HTTP_SERVER+"?route=sitebar/login/logout", 
		function(data){
			if(data == "true")
			{
				alert("Bạn đã đăng xuất thành công!");
				//window.location = "<?php echo HTTP_SERVER?>site/default/login";
				window.location = HTTP_SERVER;
			}
			else
			{
				
				$('#error').html(data).show('slow');
				
				
			}
			$.unblockUI();
		}
	);	
}

function selectFilm(eid,type)
{
    $('#handler').val(eid);
	$('#outputtype').val(type);
	$('body').append('<div id="filmform" style="display:none"></div>');
	var eid = "#filmform";
	$(eid).attr('title','Chọn film');
		$( eid ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: $(document).width()-100,
			height: window.innerHeight,
			modal: true,
			close:function()
				{
					$(eid).remove();
				},
			
		});
	
		$(eid).dialog("open");
		$(eid).html(loading);
		$(eid).load("?route=lotte/movie&opendialog=true",function(){
				
		});
		
}

function browserFile(eid,type)
{
	
    $('#handler').val(eid);
	$('#outputtype').val(type);
	var eid = "fileform";
	$('body').append('<div id="'+eid+'" style="display:none"></div>');
	$("#"+eid).attr('title','Chọn hình');
	
	switch(type)
	{
		case "single":
		case "editor":
		case "video":
		
		$("#"+eid).dialog({
			
			width: $(document).width()-100,
			height: window.innerHeight,
			
			
		});
		break;
		case "multi":
		$("#"+eid).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: $(document).width()-100,
			height: window.innerHeight,
			modal: true,
			close:function()
			{
				$("#"+eid).remove();
			},
			buttons:
			{
				"Chọn":function()
				{
					$('.selectfile').each(function(index, element) {
						var filepath = $(this).attr('filepath');
						var filename = $(this).attr('filename');
						var imagethumbnail = $(this).attr('imagethumbnail');
						$('#attachment').append(attachment.creatAttachmentRow(filepath,filename,imagethumbnail));
					});
					$("#"+eid).dialog( "close" );
				},
				"Bỏ qua":function()
				{
					$("#"+eid).dialog( "close" );
				}
			}
		});
		break;
	}
	
	$("#"+eid).dialog("open");	
	$("#"+eid).html(loading);
	$("#"+eid).load("?route=core/file&dialog=true&type="+type);
	
}
function intSeleteFile(type)
{
	
	switch(type)
	{
		case "single":
			$('.fileitem').dblclick(function(e) {
				$('#'+ $('#handler').val()+'_fileid').val($(this).attr('id'));
				$('#'+ $('#handler').val()).html($(this).attr('filepath'));
				$('#'+ $('#handler').val()+'_filepath').val($(this).attr('filepath'));
				$('#'+ $('#handler').val()+'_preview').attr('src',$(this).attr('imagethumbnail'));
				
				/*$('#imagepreview').attr('src',$(this).attr('imagethumbnail'));
				$('#imageid').val(this.id);
				$('#imagepath').val($(this).attr('filepath'));
				$('#imagethumbnail').val($(this).attr('imagethumbnail'));*/
				
				$("#fileform").dialog( "close" );
				
				
			});			
			break;
			
		case "editor":
			$('.fileitem').dblclick(function(e) {

				
				width = "";
							
				var value = "<img src='"+ HTTP_IMAGE+$(this).attr('filepath')+"'/>";
				
				var oEditor = CKEDITOR.instances[''+$('#handler').val()] ;
				
				
				// Check the active editing mode.
				if (oEditor.mode == 'wysiwyg' )
				{
					// Insert the desired HTML.
					oEditor.insertHtml( value ) ;
					
					var temp = oEditor.getData()
					oEditor.setData( temp );
				}
				else
					alert( 'You must be on WYSIWYG mode!' ) ;
				$("#fileform").dialog( "close" );
			});			
			break;
		case "video":
			$('.fileitem').dblclick(function(e) {

				
				width = "";
							
				
				//var str = '<video width="100%" controls="true" src="'+ HTTP_IMAGE+$(this).attr('filepath')+'" type="video/mp4"></video>';
               var str = '<embed width="790" height="444" wmode="transparent" flashvars="file='+ HTTP_IMAGE+$(this).attr('filepath')+'&amp;image=&amp;provider=video" allowfullscreen="false" allowscriptaccess="always" src="'+HTTP_DOMAIN+'component/player/mediaplayer.swf" name="player2" type="application/x-shockwave-flash">';
                
				var oEditor = CKEDITOR.instances[''+$('#handler').val()] ;
				
				oEditor.insertHtml( str );
				// Check the active editing mode.
				/*if (oEditor.mode == 'wysiwyg' )
				{
					// Insert the desired HTML.
					
					
					//var temp = oEditor.getData()
					//oEditor.setData( temp );
				}
				else
					alert( 'You must be on WYSIWYG mode!' ) ;*/
				$("#fileform").dialog( "close" );
			});			
			break;
		case "multi":
			$('.filelist').click(function(e) {
                //$('#popup-seletetion').append($(this))
            });
			break;
	}
}

function addImageTo()
{
	var str= trim($("#listselectfile").val(),",");
	var arr = str.split(",");
	
	if(str!="")
	{
		for (i=0;i<arr.length;i++)
		{
			$.getJSON("?route=core/file/getFile&fileid="+arr[i], 
				function(data) 
				{
					switch($('#outputtype').val())
					{
						case 'image':
							if(isImage(data.file.extension))
							{
								width = "";
								
								width = 'width="200px"'
								var value = "<img src='<?php echo HTTP_IMAGE?>"+data.file.filepath+"' " + width +"/>";
								
								$('#'+ $('#handler').val()).html(value)
								$('#'+ $('#handler').val()+'_filepath').val(data.file.filepath);
							}
							else
							{
								alert('Bạn phải chọn file hình');	
							}						
							break;
						default:
							var value = data.file.filepath;
								
							$('#'+ $('#handler').val()).html(value)
							$('#'+ $('#handler').val()+'_filepath').val(data.file.filepath);
					}
					
				});
		}
	}
}
function toPhpTime(t)
{
	var d = new Date(t);
	var date = d.getFullYear()+"-"+ (d.getMonth()<10?"0"+(d.getMonth()+1):d.getMonth()+1) +"-"+(d.getDate()<10?"0"+d.getDate():d.getDate());
	var time = (d.getHours()<10?"0"+d.getHours():d.getHours())+":"+(d.getMinutes()<10?"0"+d.getMinutes():d.getMinutes())+":"+ (d.getSeconds()<10?"0"+d.getSeconds():d.getSeconds());
	
	return date+" "+time;
}
function intToDate(n)
{
	var d = new Date(n);
	var date =(d.getDate()<10?"0"+d.getDate():d.getDate())+"-"+(d.getMonth()<10?"0"+(d.getMonth()+1):d.getMonth()+1)+"-"+d.getFullYear();
	return date;
}
function Attachment()
{
	this.index = 0;
	this.removeAttachmentRow = function(index)
	{
		$("#delfile").append('<input type="hidden" id="attimageid'+attachment.index+'" name="delfile['+index+']" value="'+$("#attimageid"+index).val()+'" />');
		$("#attrows"+index).html("")
	}
	this.creatAttachmentRow = function(iid,path,thums)
	{
		
		row = '<div id="attrows'+attachment.index+'"><img src="'+thums+'" /><input type="hidden" id="attimageid'+attachment.index+'" name="attimageid['+attachment.index+']" value="'+iid+'" />'+path+' <a id="removerow'+attachment.index+'" onclick="attachment.removeAttachmentRow('+attachment.index+')" class="button" >Remove</a></div>';
		attachment.index++;
		return row;	
	}
	this.creatAttachmentRowView = function(iid,name,path,thums)
	{
		row = '<div id="attrows'+attachment.index+'"><img src="'+thums+'" /><input type="hidden" id="attimageid'+attachment.index+'" name="attimageid['+attachment.index+']" value="'+iid+'" />'+'<a href="'+path+'" target="_blank">'+name+'</a>';
		attachment.index++;
		return row;
	}

}
var attachment = new Attachment();

$.xhrPool = [];
$.xhrPool.abortAll = function() {
    $(this).each(function(idx, jqXHR) {
        jqXHR.abort();
    });
    $.xhrPool = [];
};

$.ajaxSetup({
    beforeSend: function(jqXHR) {
        $.xhrPool.push(jqXHR);
		//console.log($.xhrPool);
    },
    complete: function(jqXHR) {
        var index = $.xhrPool.indexOf(jqXHR);
        if (index > -1) {
            $.xhrPool.splice(index, 1);
        }
    }
});