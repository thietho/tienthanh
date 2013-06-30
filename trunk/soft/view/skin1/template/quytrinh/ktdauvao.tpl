<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">        	
        <div class="button right">
        	<input class="button" id="btnListBMTN13" value="Phiếu đề xuất mua vật tư, nguyên liệu (BM-VT-03)" type="button">
        	<input class="button" id="btnLapBMVT03" value="Lập phiếu đề xuất mua vật tư, nguyên liệu (BM-VT-03)" type="button">
            <!--<input class="button" id="btnListBMTN13" value="Phiếu yêu cầu kết quả nghiệm thu (BM-TN-13)" type="button">
            <input class="button" id="btnLapBMTN13" value="Lập phiếu yêu cầu kết quả nghiệm thu (BM-TN-13)" type="button">
            <input class="button" id="btnListBMTN14" value="Phiếu kết quả thử nghiệm (BM-TN-14)" type="button">
            <input class="button" id="btnLapBMTN14" value="Lập phiếu kết quả thử nghiệm (BM-TN-14)" type="button">-->
        </div>
        <div class="clearer">^&nbsp;</div>
        
        <div id="formshow">
        </div>
            
        
        
        
    </div>
    
</div>
<script language="javascript">

function KTDauVao()
{
	this.loadData = function(url)
	{
		$('#formshow').html(loading);
		$('#formshow').load(url);
	}
}
var ktdv = new KTDauVao();
$('#btnListBMTN13').click(function(e) {
    ktdv.loadData('?route=bm/bmvt03/getList');
});
$('#btnLapBMVT03').click(function(e) {
    ktdv.loadData('?route=bm/bmvt03/create');
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
		row += '<td><select id="madonvi-'+ this.index +'" name="madonvi['+ this.index +']"><?php echo $cbDonViTinh?></select></td>';
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
		$('#madonvi-'+ this.index).val(this.madonvi);
		$('#chatluong-'+ this.index).val(this.chatluong);
		//Get ton hien tai
		//Get ton toi thieu
		itemid = this.itemid;
		
		var pos = this.index;
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
			});
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
	this.createDotGiaoHang = function()
	{
		
	}
}
var bm = new BMVT03();
</script>