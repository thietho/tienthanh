<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">        	
        
        <div class="clearer">^&nbsp;</div>
        <h3>Các phiếu đề xuất mua vật tư, nguyên liệu(BM-VT-03) đã được phê duyệt</h3>
        
        <table>
            <thead>
                <tr>
                    <th>Số phiếu(BM-VT-03)</th>
                    <th>Nhân viên lập</th>
                    <th>Ngày lập</th>
                    
                   
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <?php foreach($data_bmvt03 as $item){ ?>
                <tr>
                    <td><?php echo $item['sophieu']?></td>
                    <td><?php echo $this->document->getNhanVien($item['nhanvienlap'])?></td>
                    <td><?php echo $this->date->formatMySQLDate($item['ngaylapphieu'])?></td>
                </tr>
                <tr>
                	<td id="dotgiaohang-<?php echo $item['id']?>" bmvt03id="<?php echo $item['id']?>" class="dotgiaohang" colspan="3">
                    	
                    </td>
                </tr>
                <?php } ?>
            </tbody>
        </table>
            
        
        
        
    </div>
    
</div>
<script language="javascript">
function BMTN13()
{
	this.index = 0;
	this.id = 0;
	this.itemtype = "";
	this.itemid = "";
	this.itemcode = "";
	this.itemname = "";
	this.madonvi = "";
	this.tendonvi = "";
	this.trongluong = 0;
	this.soluong = 0;
	this.chatluong = "";
	this.lothang = "";
	this.cbChatLuong = '<?php echo $cbChatLuong?>';
	
	this.createRow = function()
	{
		var row = '<tr id="row'+ this.index +'">';
		//Ma so - Qui cach
		row += '<td><input type="hidden" id="ctid-'+ this.index +'" name="ctid['+ this.index +']" value="'+ this.id +'"><input type="hidden" id="itemtype-'+ this.index +'" name="itemtype['+ this.index +']" value="'+ this.itemtype +'"><input type="hidden" id="itemid-'+ this.index +'" name="itemid['+ this.index +']" value="'+ this.itemid +'"><input type="hidden" id="itemcode-'+ this.index +'" name="itemcode['+ this.index +']" value="'+ this.itemcode +'"><input type="hidden" id="itemname-'+ this.index +'" name="itemname['+ this.index +']" value="'+ this.itemname +'">'+ this.itemname +'</td>';
		//Don vi
		row += '<td><select id="madonvi-'+ this.index +'" name="madonvi['+ this.index +']"><?php echo $cbDonViTinh?></select></td>';
		//Trong luong
		row += '<td><input type="text" name="trongluong['+this.index+']" value="'+ this.trongluong +'" class="text number"/></td>';
		//So luong
		row += '<td><input type="text" name="soluong['+this.index+']" value="'+ this.soluong +'" class="text number"/></td>';
		//Chat luong
		row += '<td><select id="chatluong-'+ this.index +'" name="chatluong['+this.index+']">'+ this.cbChatLuong +'</select></td>';
		//Lot hang hoa
		row += '<td><input type="text" name="lothang['+this.index+']" value="'+ this.lothang +'" class="text"/></td>';
		//Control
		//row += '<td><input type="button" class="button" value="Xóa" onclick="bmtn13.remove('+this.index+')"></td>';
		row += '</tr>';
		$('#listhanghoa').append(row);
		$('#madonvi-'+ this.index).val(this.madonvi);
		$('#chatluong-'+ this.index).val(this.chatluong);
		this.index++;
		numberReady();
	}
	
	this.remove = function(pos)
	{
		$("#delid").val($("#delid").val()+","+ $('#ctid-'+pos).val());
		$("#row"+pos).remove();
	}
	
	this.loadDotGiaoHang = function()
	{
		$('.dotgiaohang').each(function(index, element) {
			var bmvt03id = $(this).attr('bmvt03id');
			$(this).load("?route=bm/bmtn13/dotGiaoHang&bmvt03id="+bmvt03id);
		});
	}
	this.viewDotGiaoHang = function(id,title)
	{
		$("#popup").attr('title',title);
					$( "#popup" ).dialog({
						autoOpen: false,
						show: "blind",
						hide: "explode",
						width: $(document).width()-100,
						height: window.innerHeight,
						modal: true,
						close: function(event, ui) {
							
							
							
						},
						buttons: {
							'Lập phiếu yêu cầu kết quả khiểm nghiệm(BM-TN-13)': function() {
								
								 
								bmtn13.create(id);
							},
							
						}
					});
				
					
		$("#popup-content").load("?route=bm/bmvt03/viewDotGiaoHang&id="+id,function(){
			$("#popup").dialog("open");
		});
	}
	this.create = function(dotgiaohangid)
	{
		$('body').append('<div id="popupbmtn13form" style="display:none"></div>');
		var eid="#popupbmtn13form";
		$(eid).attr('title','Phiếu yêu cầu kết quả khiểm nghiệm(BM-TN-13)');
			$( eid ).dialog({
				autoOpen: false,
				show: "blind",
				hide: "explode",
				width: $(document).width()-100,
				height: window.innerHeight,
				modal: true,
				close: function(event, ui) {
					$(eid).remove();
					
				},
				buttons: {
					'Lưu phiếu': function() {
						bmtn13.save(false);
						
					},
					'Lưu & in phiếu': function() {
						bmtn13.save(true);
						
					},
				}
			});
		
			
		$(eid).load("?route=bm/bmtn13/create&dotgiaohangid="+dotgiaohangid,function(){
			$(eid).dialog("open");
		});
	}
	this.edit = function(dotgiaohangid,bmtn13id)
	{
		$('body').append('<div id="popupbmtn13form" style="display:none"></div>');
		var eid="#popupbmtn13form";
		$(eid).attr('title','Phiếu yêu cầu kết quả khiểm nghiệm(BM-TN-13)');
			$( eid ).dialog({
				autoOpen: false,
				show: "blind",
				hide: "explode",
				width: $(document).width()-100,
				height: window.innerHeight,
				modal: true,
				close: function(event, ui) {
					$(eid).remove();
					
				},
				buttons: {
					'Lưu phiếu': function() {
						bmtn13.save(false);
						
					},
					'Lưu & in phiếu': function() {
						bmtn13.save(true);
						
					},
				}
			});
		
			
		$(eid).load("?route=bm/bmtn13/edit&dotgiaohangid="+dotgiaohangid+"&id="+bmtn13id,function(){
			$(eid).dialog("open");
		});
	}
	this.save = function(isprint)
	{
		$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
		$.post("?route=bm/bmtn13/save", $("#frm_bmtn13").serialize(),
			function(data){
				
				var obj = $.parseJSON(data);
				
				if(obj.error == "")
				{
					alert("Lưu phiếu thành công");
					if(isprint)
					{
						bmtn13.view(obj.id);
					}
				}
				else
				{
				
					$('#error').html(obj.error).show('slow');
					
					
				}
				$.unblockUI();
				bmtn13.loadDotGiaoHang();
			}
		);
	}
	this.view = function(bmtn13id)
	{
		$("#popup").attr('title','Phiếu yêu cầu kiểm kết quả nghiệm thu');
					$( "#popup" ).dialog({
						autoOpen: false,
						show: "blind",
						hide: "explode",
						width: $(document).width()-100,
						height: window.innerHeight,
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
	
	
	
}
var bmtn13 = new BMTN13();
$(document).ready(function(e) {
    bmtn13.loadDotGiaoHang();
});
</script>