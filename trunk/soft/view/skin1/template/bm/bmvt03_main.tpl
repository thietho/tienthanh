<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">        	
        <div class="button right">
       		
            <?php if($this->user->checkPermission("bm/bmvt03/create")==true){ ?>
        	<input class="button" id="btnLapBMVT03" value="Lập phiếu đề xuất mua vật tư, nguyên liệu (BM-VT-03)" type="button">
            <?php } ?>
        </div>
        <div class="clearer">^&nbsp;</div>
        
        <div id="formshow">
        </div>
            
        
        
        
    </div>
    
</div>
<script language="javascript">
$(document).ready(function(e) {
    ktdv.loadData('?route=bm/bmvt03/getList');
});
function KTDauVao()
{
	this.loadData = function(url)
	{
		$('#formshow').html(loading);
		$('#formshow').load(url);
	}
}
var ktdv = new KTDauVao();

$('#btnLapBMVT03').click(function(e) {
    bm.edit("");
});
/*$('#btnListBMTN13').click(function(e) {
    ktdv.loadData('?route=bm/bmtn13/getList');
});
$('#btnLapBMTN13').click(function(e) {
    ktdv.loadData('?route=bm/bmtn13/create');
});
$('#btnListBMTN14').click(function(e) {
    ktdv.loadData('?route=bm/bmtn14/getList');
});
$('#btnLapBMTN14').click(function(e) {
    ktdv.loadData('?route=bm/bmtn14/create');
});*/
function BMVT03()
{
	this.index = 0;
	this.id = 0;
	this.itemtype = "";
	this.itemid = "";
	this.itemcode = "";
	this.itemname = "";
	this.madonvi = "";
	this.tendonvi = "";
	this.tonhientai = 0;
	this.tontonthieu = 0;
	this.muatoithieu = 0;
	this.thoigiayeucau = "";
	this.mucdichsudung = "";
	
	
	this.createRow = function()
	{
		var row = '<tr id="row'+ this.index +'">';
		//Ten hang hoa va qui cach
		row += '<td><input type="hidden" id="ctid-'+ this.index +'" name="ctid['+ this.index +']" value="'+ this.id +'"><input type="hidden" id="itemtype-'+ this.index +'" name="itemtype['+ this.index +']" value="'+ this.itemtype +'"><input type="hidden" id="itemid-'+ this.index +'" name="itemid['+ this.index +']" value="'+ this.itemid +'"><input type="hidden" id="itemcode-'+ this.index +'" name="itemcode['+ this.index +']" value="'+ this.itemcode +'"><input type="hidden" id="itemname-'+ this.index +'" name="itemname['+ this.index +']" value="'+ this.itemname +'">'+ this.itemname +'</td>';
		//Don vi
		row += '<td><select id="madonvi-'+ this.index +'" name="madonvi['+ this.index +']" class="madonvi" ref="'+ this.index +'"></select></td>';
		//Ton hien tai
		row += '<td><input type="hidden" id="tonhientai-'+ this.index +'" name="tonhientai['+ this.index +']" value="'+ this.tonhientai +'"><span id="tonhientai_text-'+ this.index +'"></span></td>';
		
		//Ton T/thieu
		row += '<td class="number"><input type="hidden" id="tontonthieu-'+ this.index +'" name="tontonthieu['+ this.index +']" value="'+ this.tontonthieu +'"><span id="tontonthieu_text-'+ this.index +'"></span></td>';
		//Mua T/thieu
		row += '<td><input type="text" name="muatoithieu['+this.index+']" value="'+ this.muatoithieu +'" class="text number"/></td>';
		
		//T/G yeu cau cung ung
		row += '<td><input type="text" name="thoigiayeucau['+this.index+']" value="'+ this.thoigiayeucau +'" class="text date"/></td>';
		//Muc dich su dung
		row += '<td><input type="text" name="mucdichsudung['+this.index+']" value="'+ this.mucdichsudung +'" class="text"/></td>';
		//Control
		row += '<td><input type="button" class="button" value="Xóa" onclick="bm.remove('+this.index+')"></td>';
		row += '</tr>';
		$('#listhanghoa').append(row);
		
		$('#chatluong-'+ this.index).val(this.chatluong);
		//Get ton hien tai
		//Get ton toi thieu
		itemid = this.itemid;
		
		var pos = this.index;
		var madonvi = this.madonvi;
		switch(this.itemtype)
		{
			case "nguyenlieu":
			case "vattu":
				$.getJSON("?route=quanlykho/nguyenlieu/getNguyenLieu",
					{
						col:'id',
						val: itemid
					},
					function(data)
					{
						tontoithieu = data.nguyenlieus[0].tontoithieu;
						$('#tontonthieu-'+pos).val(tontoithieu);
						$('#tontonthieu_text-'+pos).html(formateNumber(tontoithieu));
						
						$.getJSON('?route=quanlykho/donvitinh/getListDonVi&madonvi='+ data.nguyenlieus[0].madonvi,
						function(data)
						{
							var str = "";
							for(i in data)
							{
								str += '<option value="'+ data[i].madonvi +'">'+ data[i].tendonvitinh +'</option>';
								
							}
							$('#madonvi-'+ pos).html(str);
							$('#madonvi-'+ pos).val(madonvi);
						});
					});
				break;
			case "linhkien":
				$.getJSON("?route=quanlykho/linhkien/getLinhKien",
					{
						col:'id',
						val: itemid
					},
					function(data)
					{
						
						tontoithieu = data.linhkiens[0].tontoithieu;
						$('#tontonthieu-'+pos).val(tontoithieu);
						$('#tontonthieu_text-'+pos).html(formateNumber(tontoithieu));
						$.getJSON('?route=quanlykho/donvitinh/getListDonVi&madonvi='+ data.linhkiens[0].madonvi,
						function(data)
						{
							var str = "";
							for(i in data)
							{
								str += '<option value="'+ data[i].madonvi +'">'+ data[i].tendonvitinh +'</option>';
								
							}
							$('#madonvi-'+ pos).html(str);
							$('#madonvi-'+ pos).val(madonvi);
						});
					});
				break;
		}
		this.index++;
		numberReady();
	}
	
	this.remove = function(pos)
	{
		$("#delid").val($("#delid").val()+","+ $('#ctid-'+pos).val());
		$("#row"+pos).remove();
	}
	this.del = function(id)
	{
		var answer = confirm("Bạn có muốn xóa phiếu này không?")
		if (answer)
		{
			$.get("?route=bm/bmvt03/delete&id="+id,
				function(data)
				{
					ktdv.loadData('?route=bm/bmvt03/getList');
				});
		}
	}
	this.view = function(id,callback)
	{
		$("#popup").attr('title','Phiếu đề xuất mua vật tư, nguyên liệu');
					$( "#popup" ).dialog({
						autoOpen: false,
						show: "blind",
						hide: "explode",
						width: 1000,
						height: 500,
						modal: true,
						close: function(event, ui) {
							//executeFunctionByName("ktdv.loadData",'?route=bm/bmvt03/getList');
							if(callback !="")
								setTimeout(callback,50);
							
						},
						buttons: {
							'Đóng': function() {
								$( this ).dialog( "close" );
								//ktdv.loadData('?route=bm/bmvt03/getList');
								if(callback !="")
									setTimeout(callback,50);
							},
							'In': function(){
								openDialog("?route=bm/bmvt03/view&id="+id+"&dialog=print",800,500)
								//ktdv.loadData('?route=bm/bmvt03/getList');
								if(callback !="")
									setTimeout(callback,50);
								$( this ).dialog( "close" );
							},
						}
					});
				
					
		$("#popup-content").load("?route=bm/bmvt03/view&id="+id,function(){
			$("#popup").dialog("open");	
		});
	}
	this.pheduyet = function(id)
	{
		$("#popup").attr('title','Phiếu đề xuất mua vật tư, nguyên liệu');
					$( "#popup" ).dialog({
						autoOpen: false,
						show: "blind",
						hide: "explode",
						width: 1000,
						height: 500,
						modal: true,
						close: function(event, ui) {
							
							
							
						},
						buttons: {
							'Lưu': function() {
								$.post("?route=bm/bmvt03/savePheDuyet",$('#frm_pheduyet').serialize(),
									function(data)
									{
										var obj = $.parseJSON(data);
			
										if(obj.error == "")
										{
											alert("Lưu phê duyệt thành công");
											ktdv.loadData('?route=bm/bmvt03/getList');
										}
									});
								//$( this ).dialog( "close" );
								//ktdv.loadData('?route=bm/bmvt03/getList');
								
							},
							'In': function(){
								openDialog("?route=bm/bmvt03/view&id="+id+"&dialog=print",800,500)
								//ktdv.loadData('?route=bm/bmvt03/getList');
								
								$( this ).dialog( "close" );
							},
						}
					});
				
					
		$("#popup-content").load("?route=bm/bmvt03/pheduyet&id="+id,function(){
			$("#popup").dialog("open");
		});
	}
	this.phanHoiThoiGianCungUng = function(id)
	{
		$("#popup").attr('title','Phiếu đề xuất mua vật tư, nguyên liệu');
					$( "#popup" ).dialog({
						autoOpen: false,
						show: "blind",
						hide: "explode",
						width: 1000,
						height: 500,
						modal: true,
						close: function(event, ui) {
							
							
							
						},
						buttons: {
							'Lưu': function() {
								$.post("?route=bm/bmvt03/savePhanHoiThoiGianCungUng",$('#frm_phanhoithoigiancungung').serialize(),
									function(data)
									{
										var obj = $.parseJSON(data);
			
										if(obj.error == "")
										{
											alert("Lưu phản hồi thời gian cung ứng thành công");
											ktdv.loadData('?route=bm/bmvt03/getList');
										}
									});
								//$( this ).dialog( "close" );
								//ktdv.loadData('?route=bm/bmvt03/getList');
								
							},
							'In': function(){
								openDialog("?route=bm/bmvt03/view&id="+id+"&dialog=print",800,500)
								//ktdv.loadData('?route=bm/bmvt03/getList');
								
								$( this ).dialog( "close" );
							},
						}
					});
				
					
		$("#popup-content").load("?route=bm/bmvt03/phanHoiThoiGianCungUng&id="+id,function(){
			$("#popup").dialog("open");
		});
	}
	this.dotGiaoHang = function(bmvt03id)
	{
		
	}
	this.createDotGiaoHang = function(id)
	{
		$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
		$.post("?route=bm/bmvt03/saveDotGiaoHang", $("#frm_dotgiaohangfrm").serialize(),
			function(data){
				var obj = $.parseJSON(data);
				if(obj.error == "")
				{
					ktdv.loadData('?route=bm/bmvt03/dotGiaoHang&bmvt03id='+id);
				}
				else
				{
				
					$('#error').html(obj.error).show('slow');
					
					
				}
				$.unblockUI();
			}
		);
	}
	this.viewDotGiaoHang = function(id,title)
	{
		$("#popup").attr('title',title);
					$( "#popup" ).dialog({
						autoOpen: false,
						show: "blind",
						hide: "explode",
						width: 1000,
						height: 500,
						modal: true,
						close: function(event, ui) {
							
							
							
						},
						buttons: {
							'Lập phiếu yêu cầu kết quả khiểm nghiệm(BM-TN-13)': function() {
								 ktdv.loadData('?route=bm/bmtn13/create&dotgiaohangid='+id);
								 $( this ).dialog( "close" );
								
							},
							'Lập phiếu cân hàng(BM-VT-17)': function(){
								 ktdv.loadData('?route=bm/bmvt17/create&dotgiaohangid='+id);
								 $( this ).dialog( "close" );
							},
						}
					});
				
					
		$("#popup-content").load("?route=bm/bmvt03/viewDotGiaoHang&id="+id,function(){
			$("#popup").dialog("open");
		});
	}
	this.delDotGiaoHang = function(dotgiaohangid,bmvt03id)
	{
		$.get("?route=bm/bmvt03/delDotGiaoHang&id="+dotgiaohangid,function()
			{
				ktdv.loadData('?route=bm/bmvt03/dotGiaoHang&bmvt03id='+bmvt03id);
			});
	}
	this.edit = function(bmtn13id)
	{
		$('body').append('<div id="popupvt03" style="display:none"></div>');
		$("#popupvt03").attr('title','Phiếu đề xuất mua vật tư, nguyên liệu');
			$( "#popupvt03" ).dialog({
				autoOpen: false,
				show: "blind",
				hide: "explode",
				width: 1000,
				height: 500,
				modal: true,
				close: function(event, ui) {
					$('#popupvt03').remove();
					
				},
				buttons: {
					'Lưu phiếu': function() {
						$.blockUI({ message: "<h1>Please wait...</h1>" }); 
		
						$.post("?route=bm/bmvt03/save", $("#frm_bmv03").serialize(),
							function(data){
								$.unblockUI();
								var obj = $.parseJSON(data);
								
								if(obj.error == "")
								{
									alert("Lưu phiếu thành công");
									ktdv.loadData('?route=bm/bmvt03/getList');
									$("#popupvt03").dialog( "close" );
								}
								else
								{
								
									$('#error').html(obj.error).show('slow');
									
									
								}
								
							}
						);
						
						ktdv.loadData('?route=bm/bmvt03/getList');
						
					},
					'Lưu & in phiếu': function(){
						$.blockUI({ message: "<h1>Please wait...</h1>" }); 
		
						$.post("?route=bm/bmvt03/save", $("#frm_bmv03").serialize(),
							function(data){
								$.unblockUI();
								var obj = $.parseJSON(data);
								
								if(obj.error == "")
								{
									alert("Lưu phiếu thành công");
									bm.view(obj.id,"ktdv.loadData('?route=bm/bmvt03/getList')");
									$("#popupvt03").dialog( "close" );
									
								}
								else
								{
								
									$('#error').html(obj.error).show('slow');
									
									
								}
								
							}
						);
					},
				}
			});
		
			
		$("#popupvt03").load("?route=bm/bmvt03/edit&id="+bmtn13id,function(){
			$("#popupvt03").dialog("open");
		});
	}
	this.viewBMTN13 = function(bmtn13id)
	{
		$("#popup").attr('title','Phiếu yêu cầu kiểm kết quả nghiệm thu');
					$( "#popup" ).dialog({
						autoOpen: false,
						show: "blind",
						hide: "explode",
						width: 1000,
						height: 500,
						modal: true,
						close: function(event, ui) {
							//ktdv.loadData("?route=bm/bmvt03/dotGiaoHang&id=<?php echo $dotgiaohangid?>");
							
							
						},
						buttons: {
							
							'In': function(){
								openDialog("?route=bm/bmtn13/view&id="+ bmtn13id +"&dialog=print",800,500);
								//ktdv.loadData("?route=bm/bmvt03/dotGiaoHang&id=<?php echo $dotgiaohangid?>");
								
								$( this ).dialog( "close" );
							},
						}
					});
				
					
		$("#popup-content").load("?route=bm/bmtn13/view&id="+bmtn13id,function(){
			$("#popup").dialog("open");
		});	
	}
	
	this.viewBMVT17 = function(bmvt17id)
	{
		$("#popup").attr('title','Phiếu cân hàng');
					$( "#popup" ).dialog({
						autoOpen: false,
						show: "blind",
						hide: "explode",
						width: 1000,
						height: 500,
						modal: true,
						close: function(event, ui) {
							//ktdv.loadData("?route=bm/bmvt03/dotGiaoHang&id=<?php echo $dotgiaohangid?>");
							
							
						},
						buttons: {
							
							'In': function(){
								openDialog("?route=bm/bmvt17/view&id="+ bmvt17id +"&dialog=print",450,500);
								//ktdv.loadData("?route=bm/bmvt03/dotGiaoHang&id=<?php echo $dotgiaohangid?>");
								
								$( this ).dialog( "close" );
							},
						}
					});
				
					
		$("#popup-content").load("?route=bm/bmvt17/view&id="+bmvt17id,function(){
			$("#popup").dialog("open");
		});	
	}
	this.viewBMVT16 = function(bmvt16id)
	{
		$("#popup").attr('title','Phiếu nhập vật tư hàng hóa');
					$( "#popup" ).dialog({
						autoOpen: false,
						show: "blind",
						hide: "explode",
						width: 1000,
						height: 500,
						modal: true,
						close: function(event, ui) {
							//ktdv.loadData("?route=bm/bmvt03/dotGiaoHang&id=<?php echo $dotgiaohangid?>");
							
							
						},
						buttons: {
							
							'In': function(){
								openDialog("?route=bm/bmvt16/view&id="+ bmvt16id +"&dialog=print",1000,500);
								//ktdv.loadData("?route=bm/bmvt03/dotGiaoHang&id=<?php echo $dotgiaohangid?>");
								
								$( this ).dialog( "close" );
							},
						}
					});
				
					
		$("#popup-content").load("?route=bm/bmvt16/view&id="+bmvt16id,function(){
			$("#popup").dialog("open");
		});	
	}
}
var bm = new BMVT03();
</script>