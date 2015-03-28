function showFile(filepath)
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

function showMediaForm(fileid)
{
	var eid = "mediaform";
	$('body').append('<div id="'+eid+'" style="display:none"></div>');
	
	$("#"+eid).attr('title','Thông tin file');
		$("#"+eid).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 500,
			height: window.innerHeight,
			modal: true,
			close:function()
				{
					$("#"+eid).remove();
				},
			buttons: {
				
				
				
				'Lưu':function()
				{
					$.post("?route=core/media/addMediaQuick",$('#frmQuickAddMedia').serialize(),
					function(data)
					{
						var obj = $.parseJSON(data);
						if(obj.error=="")
						{
							//loadData("?route=addon/order/listProduct");
							$("#"+eid).dialog("close");
						}
						else
						{
							alert(obj.error);
						}
					});
				},
				'Đóng': function() 
				{
					
					$("#mediaform").dialog( "close" );
					
				},
			}
		});
	
		$("#"+eid).dialog("open");
		$("#"+eid).html(loading);
		$("#"+eid).load("?route=core/media/fileToMedia&fileid="+fileid+"&dialog=true",function(){
			
		});
}
function showProductForm(mediaid,mediaparentid,funcname)
{
	var eid = "mediaform";
	$('body').append('<div id="'+eid+'" style="display:none"></div>');
	
	$("#"+eid).attr('title','Thông tin sản phẩm');
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
			buttons: {
				'Sưa với editor':function()
				{
					window.location = "?route=module/product/update&mediaid="+mediaid+"&mediaparent="+mediaparentid;
				},
				'Lưu':function()
				{
					$.blockUI({ message: "<h1>Please wait...</h1>" });
					/*var oEditor = CKEDITOR.instances['description'] ;
					var pageValue = oEditor.getData();
					$('textarea#description').val(pageValue);
					
					var oEditor = CKEDITOR.instances['summary'] ;
					var pageValue = oEditor.getData();
					$('textarea#summary').val(pageValue);*/
					$.post("?route=core/postcontent/savepost",$('#frmPost').serialize(),
					function(data)
					{
						
						var obj = $.parseJSON(data);
						if(obj.error=="")
						{
							$("#"+eid).dialog("close");
							//Cap nhap lay thong tin tren list
							/*$("#"+obj.mediaid+" .mediaid").html(obj.mediaid);
							$("#"+obj.mediaid+" .code").html(obj.code);
							$("#"+obj.mediaid+" .title").html(obj.title);
							$("#"+obj.mediaid+" .color").html(obj.color);
							$("#"+obj.mediaid+" .barcode").html(obj.barcode);
							$("#"+obj.mediaid+" .ref").html(obj.ref);
							var price = obj.price;
							if(obj.noteprice !="")
							{
								price += "<br />("+obj.noteprice+")";
							}
							$("#"+obj.mediaid+" .price").html(price);
							$("#"+obj.mediaid+" .discountpercent").html(obj.discountpercent+"%");	
							$("#"+obj.mediaid+" .pricepromotion").html(obj.pricepromotion);	
							$("#"+obj.mediaid+" .brand").html(obj.brandname);
							$("#"+obj.mediaid+" .unit").html(obj.unitname);
							$("#"+obj.mediaid+" .status").html(obj.statusname);
							$("#"+obj.mediaid+" .imagepreview").attr("src",obj.imagepreview);*/
							//pro.searchForm();
							setTimeout(funcname,0);
							
						}
						else
						{
							$('#error').html(data).show('slow');
						}
						$.unblockUI();
					});
					
				},
				'Đóng': function() 
				{
					
					$("#"+eid).dialog( "close" );
					
				},
			}
		});
	
		$("#"+eid).dialog("open");
		$("#"+eid).html(loading);
		$("#"+eid).load("?route=module/product/update&mediaid="+mediaid+"&mediaparent="+mediaparentid+"=&dialog=true",function(){
			
		});
}
function showFolderForm(folderid,folderparent)
{
	$('body').append('<div id="folderform" style="display:none"></div>');
	var eid = "#folderform";
	$(eid).attr('title','Thư mục');
		$( eid ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 300,
			height: 300,
			modal: true,
			close:function()
				{
					$(eid).remove();
				},
			buttons: {
				
				
				
				'Lưu':function()
				{
					$.post("?route=core/file/saveFolder",$('#frm_folder').serialize(),
					function(data)
					{
						var obj = $.parseJSON(data);
						if(obj.error=="")
						{
							
							$('#folderform').dialog("close");
							$('#foldername' + folderid).html($('#foldername').val());
							loadFolder();
							if(folderparent!="")
								selectFolder(folderparent);
							else
								selectFolder(folderid);
						}
						else
						{
							alert(obj.error);
						}
					});
				},
				'Đóng': function() 
				{
					
					$(eid).dialog( "close" );
					
				},
			}
		});
	
		$(eid).dialog("open");
		$(eid).html(loading);
		$(eid).load("?route=core/file/showFolderForm&folderid="+folderid+"&folderparent="+folderparent+"&dialog=true",function(){
			
		});
}
function showFileInfor(fileid)
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
		$(eid).load("?route=core/file/detail&fileid="+fileid+"&dialog=true",function(){
			
		});
}
function showFolderMoveForm()
{
	$('body').append('<div id="folderform" style="display:none"></div>');
	var eid = "#folderform";
	$(eid).attr('title','Thư mục');
		$( eid ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 300,
			height: 200,
			modal: true,
			close:function()
				{
					$(eid).remove();
				},
			buttons: {
				
				
				
				'Chọn':function()
				{
					$('.selectfile').each(function(index, element) {
                        
							var fileid = this.id;
							var folderid = $('#desfolder').val();
							$.get("?route=core/file/updateFolder&fileid="+fileid+"&folderid="+folderid,
							function(){
								 showResult("?route=core/file/getList&folderid="+$('#folderidcur').val()+"&edit=true");
							});
							
						
						
                    });
					$(eid).dialog( "close" );
				},
				'Đóng': function() 
				{
					
					$(eid).dialog( "close" );
					
				},
			}
		});
	
		$(eid).dialog("open");
		$(eid).html(loading);
		$(eid).load("?route=core/file/showFolderMoveForm&dialog=true",function(){
				
		});
}
function setForward(sitemapid)
{
	$('body').append('<div id="formforward" style="display:none"></div>');
	var eid = "#formforward";
	$(eid).attr('title','Chuyễn tiếp');
		$( eid ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 600,
			height: 300,
			modal: true,
			close:function()
				{
					$(eid).remove();
				},
			buttons: {
				
				
				
				'Lưu':function()
				{
					$.post("?route=core/sitemap/saveCol",
					{
						sitemapid:sitemapid,
						col:'forward',
						val:$('#forward').val()
					},
					function(data){
						$(eid).dialog( "close" );
					});
					
				},
				'Đóng': function() 
				{
					
					$(eid).dialog( "close" );
					
				},
			}
		});
	
		$(eid).dialog("open");
		$(eid).html(loading);
		$(eid).load("?route=core/sitemap/forwardForm&sitemapid="+sitemapid+"&dialog=true",function(){
			
		});
}

function showMediaUse(fileid)
{
	$('body').append('<div id="medialist" style="display:none"></div>');
	
	$("#medialist").attr('title','Thông tin file');
		$( "#medialist" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 500,
			height: window.innerHeight,
			modal: true,
			close:function()
				{
					$('#medialist').remove();
				},
			buttons: {
				
				'Đóng': function() 
				{
					
					$("#medialist").dialog( "close" );
					
				},
			}
		});
	
		$("#medialist").dialog("open");
		$("#medialist").html(loading);
		$("#medialist").load("?route=core/media/mediaUse&fileid="+fileid+"&dialog=true",function(){
			
		});
}
function addQuickProduct()
{
	$('body').append('<div id="frmAddSanPham" style="display:none"></div>');
	
	$("#frmAddSanPham").attr('title','Thêm nhanh sản phẩm');
	$("#frmAddSanPham").dialog({
		autoOpen: false,
		show: "blind",
		hide: "explode",
		width: 500,
		height: window.innerHeight,
		modal: true,
		close:function()
				{
					$('#frmAddSanPham').remove();
				},
		buttons: {
			
			
			'Thêm': function() 
			{
				$.post("?route=core/media/addMediaQuick",$('#frmQuickAddProduct').serialize(),
					function(data)
					{
						var obj = $.parseJSON(data);
						if(obj.error=="")
						{
							loadData("?route=addon/order/listProduct");
							$('#frmAddSanPham').dialog("close");
						}
						else
						{
							alert(obj.error);
						}
					});
				
			},
			
		}
	});

	$("#frmAddSanPham").dialog("open");
	$("#frmAddSanPham").html(loading);	
	$("#frmAddSanPham").load("?route=addon/order/showProductForm",function(){
		
	});
}
function addProduct(parent,sitemapid)
{
	$('body').append('<div id="frmProduct" style="display:none"></div>');
	
	$("#frmProduct").attr('title','Thông tin sản phẩm');
	$("#frmProduct").dialog({
		autoOpen: false,
		show: "blind",
		hide: "explode",
		width: $(document).width()-100,
		height: window.innerHeight,
		modal: true,
		close:function()
				{
					$('#frmProduct').remove();
				},
		buttons: {
			
			
			'Lưu': function() 
			{
				if(saveMedia())
				{
					$('#frmAddSanPham').dialog("close");
				}
			},
			
		}
	});

	$("#frmProduct").dialog("open");
	$("#frmProduct").html(loading);
	$("#frmProduct").load("?route=module/product/insert&sitemapid="+sitemapid+"&mediaparent="+parent+"&dialog=true",function(){
		
	});
}
function editProduct(mediaid)
{
	$('body').append('<div id="frmProduct" style="display:none"></div>');
	
	$("#frmProduct").attr('title','Thông tin sản phẩm');
	$("#frmProduct").dialog({
		autoOpen: false,
		show: "blind",
		hide: "explode",
		width: $(document).width()-100,
		height: window.innerHeight,
		modal: true,
		close:function()
				{
					$('#frmProduct').remove();
				},
		buttons: {
			
			
			'Lưu': function() 
			{
				if(saveMedia())
				{
					$('#frmAddSanPham').dialog("close");
					window.location.reload();
				}
			},
			
		}
	});

	$("#frmProduct").dialog("open");
	$("#frmProduct").html(loading);
	$("#frmProduct").load("?route=module/product/update&mediaid="+mediaid+"&dialog=true",function(){
		
	});
}
function saveMedia()
{
	$.blockUI({ message: "<h1>Please wait!!!</h1>" }); 
	var oEditor = CKEDITOR.instances['editor1'] ;
	var pageValue = oEditor.getData();
	$('textarea#editor1').val(pageValue);
	
	var oEditor = CKEDITOR.instances['summary'] ;
	var pageValue = oEditor.getData();
	$('textarea#summary').val(pageValue);
	
	$.post("?route=core/postcontent/savepost",$('#frmPost').serialize(),
		function(data){
			if(data=="true")
			{
				alert("Lưu thành công");
				window.location.reload();
				
			}
			
			$.unblockUI();
			
		});	
}
function browseProduct()
{
	$('body').append('<div id="popupbrowseproduct" style="display:none"></div>');
	$("#popupbrowseproduct").attr('title','Chọn sản phẩm');
		$("#popupbrowseproduct").dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: $(document).width()-100,
			height: window.innerHeight,
			modal: true,
			close:function()
				{
					$('#popupbrowseproduct').remove();
				},
			
		});
	
		$("#popupbrowseproduct").dialog("open");
		$("#popupbrowseproduct").html(loading);
		$("#popupbrowseproduct").load("?route=module/product&open=dialog",function(){

		});
}
function showMemberForm(memberid,strFun)
{
	$('body').append('<div id="frm_member" style="display:none"></div>');
	var eid = "#frm_member";
	$(eid).attr('title','Thông tin khách hàng');
		$( eid ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			//width: $(document).width()-100,
			width: 600,
			height: window.innerHeight,
			modal: true,
			close:function()
				{
					$(eid).remove();
				},
			buttons: {
				
				
				
				'Lưu':function()
				{
					
					$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
					$.post("?route=core/member/save", $("#frm").serialize(),
						function(data){
							var arr = data.split("-");
							if(arr[0] == "true")
							{
								//window.location = "?route=core/member";\
								alert("Lưu thành công!");
								if(strFun!="")
									var ret = eval(strFun);
								$(eid).dialog( "close" );
							}
							else
							{
							
								$('#error').html(data).show('slow');
								$.unblockUI();
								
							}
							$.unblockUI();
						}
					);	
						
						
                    
					
				},
				'Đóng': function() 
				{
					
					$(eid).dialog( "close" );
					
				},
			}
		});
		var url = "?route=core/member/insert&dialog=true";
		if(memberid)
		{
			url = "?route=core/member/update&id="+memberid+"&dialog=true";
		}
		$(eid).dialog("open");
		$(eid).html(loading);
		$(eid).load(url,function(){
			
			
		});
}
function showNhaCungCapForm(nhacungcapid,strFun)
{
	$('body').append('<div id="frm_member" style="display:none"></div>');
	var eid = "#frm_member";
	$(eid).attr('title','Thông tin khách hàng');
		$( eid ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			//width: $(document).width()-100,
			width: 600,
			height: window.innerHeight,
			modal: true,
			close:function()
				{
					$(eid).remove();
				},
			buttons: {
				
				
				
				'Lưu':function()
				{
					
					
					$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
					$.post("?route=quanlykho/nhacungcap/save", $("#frm").serialize(),
						function(data){
							var arr = data.split("-");
							if(arr[0] == "true")
							{
								//window.location = "?route=core/member";\
								alert("Lưu thành công!");
								if(strFun!="")
									var ret = eval(strFun);
								$(eid).dialog( "close" );
							}
							else
							{
							
								$('#error').html(data).show('slow');
								$.unblockUI();
								
							}
							$.unblockUI();
						}
					);	
						
						
                    
					
				},
				'Đóng': function() 
				{
					
					$(eid).dialog( "close" );
					
				},
			}
		});
		var url = "?route=quanlykho/nhacungcap/insert&dialog=true";
		if(nhacungcapid)
		{
			url = "?route=quanlykho/nhacungcap/update&id="+nhacungcapid+"&dialog=true";
		}
		$(eid).dialog("open");
		$(eid).html(loading);	
		$(eid).load(url,function(){
			
		});
}
