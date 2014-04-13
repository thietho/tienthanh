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
function BMVT16()
{
	
	this.index = 0;
	this.id = 0;
	this.itemtype = "";
	this.itemid = "";
	this.itemcode = "";
	this.itemname = "";
	this.madonvi = "";
	this.tendonvi = "";
	this.baobi = "";
	this.loaibao = "";
	this.soluongcan = 0;
	this.ghichu = "";
	this.addRow = function(itemid)
	{
		var row = '<tr id="row-'+ this.index +'">';
		//Bao bi
		row += '<td><input type="hidden" id="ctid-'+ this.index +'" name="ctid['+ this.index +']" value="'+ this.id +'"><input type="hidden" id="itemtype-'+ this.index +'" name="itemtype['+ this.index +']" value="'+ this.itemtype +'"><input type="hidden" id="itemid-'+ this.index +'" name="itemid['+ this.index +']" value="'+ this.itemid +'"><input type="hidden" id="itemcode-'+ this.index +'" name="itemcode['+ this.index +']" value="'+ this.itemcode +'"><input type="hidden" id="itemname-'+ this.index +'" name="itemname['+ this.index +']" value="'+ this.itemname +'"><input type="text" class="text" id="baobi-'+ this.index +'" name="baobi['+ this.index +']" value="'+ this.baobi +'"></td>';
		//Loai bao
		row += '<td><input type="text" class="text " id="loaibao-'+ this.index +'" name="loaibao['+ this.index +']" value="'+ this.loaibao +'"></td>';
		//So luong can
		row += '<td><input type="text" class="text number" id="soluongcan-'+ this.index +'" name="soluongcan['+ this.index +']" value="'+ this.soluongcan +'"></td>';
		//DVT
		row += '<td><input type="hidden" id="madonvi-'+ this.index +'" name="madonvi['+ this.index +']" value="'+ this.madonvi +'">'+ this.tendonvi +'</td>';
		//Ghi chu
		row += '<td><input type="text" class="text" id="ghichu-'+ this.index +'" name="ghichu['+ this.index +']" value="'+ this.ghichu +'"></td>';
		row += '<td><input type="button" class="button" value="Xóa" onclick="bmvt16.remove('+ this.index +')"></td>';
		row += '</tr>';
		$('#listcan'+itemid).append(row);
		this.index++;
		numberReady();
	}
	this.remove = function(pos)
	{
		$("#delid").val($("#delid").val()+","+ $('#ctid-'+pos).val());
		$('#row-'+pos).remove();	
	}
	
	
	this.loadDotGiaoHang = function()
	{
		$('.dotgiaohang').each(function(index, element) {
			var bmvt03id = $(this).attr('bmvt03id');
			$(this).load("?route=bm/bmvt16/dotGiaoHang&bmvt03id="+bmvt03id);
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
							'Lập phiếu cân hàng(BM-VT-17)': function() {
								
								 
								bmvt16.create(id);
							},
							
						}
					});
				
					
		$("#popup-content").load("?route=bm/bmvt03/viewDotGiaoHang&id="+id,function(){
			$("#popup").dialog("open");
		});
	}
	this.create = function(dotgiaohangid)
	{
		$('body').append('<div id="popupbmvt16form" style="display:none"></div>');
		var eid="#popupbmvt16form";
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
						bmvt16.save(false);
						
					},
					'Lưu & in phiếu': function() {
						bmvt16.save(true);
						
					},
				}
			});
		
			
		$(eid).load("?route=bm/bmvt16/create&dotgiaohangid="+dotgiaohangid,function(){
			$(eid).dialog("open");
		});
	}
	this.edit = function(dotgiaohangid,bmvt16id)
	{
		$('body').append('<div id="popupbmvt16form" style="display:none"></div>');
		var eid="#popupbmvt16form";
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
						bmvt16.save(false);
						
					},
					'Lưu & in phiếu': function() {
						bmvt16.save(true);
						
					},
				}
			});
		
			
		$(eid).load("?route=bm/bmvt16/edit&dotgiaohangid="+dotgiaohangid+"&id="+bmvt16id,function(){
			$(eid).dialog("open");
		});
	}
	this.save = function(isprint)
	{
		$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
		$.post("?route=bm/bmvt16/save", $("#frm_bmvt16").serialize(),
			function(data){
				
				var obj = $.parseJSON(data);
				
				if(obj.error == "")
				{
					alert("Lưu phiếu thành công");
					if(isprint)
					{
						bmvt16.view(obj.id);
					}
				}
				else
				{
				
					$('#error').html(obj.error).show('slow');
					
					
				}
				$.unblockUI();
				bmvt16.loadDotGiaoHang();
			}
		);
	}
	this.view = function(bmvt16id)
	{
		$("#popup").attr('title','Phiếu nhập vật tư hàng hóa');
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
								openDialog("?route=bm/bmvt16/view&id="+ bmvt16id +"&dialog=print",800,500);
								//ktdv.loadData("?route=bm/bmvt03/dotGiaoHang&id=<?php echo $dotgiaohangid?>");
								
								$( this ).dialog( "close" );
							},
						}
					});
				
					
		$("#popup-content").load("?route=bm/bmvt16/view&id="+bmvt16id,function(){
			$("#popup").dialog("open");
		});	
	}
	this.viewBMTN13 = function(bmtn13id)
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
	
	this.viewBMVT17 = function(bmvt17id)
	{
		$("#popup").attr('title','Phiếu cân hàng');
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
								openDialog("?route=bm/bmvt17/view&id="+ bmvt17id +"&dialog=print",800,500);
								//ktdv.loadData("?route=bm/bmvt03/dotGiaoHang&id=<?php echo $dotgiaohangid?>");
								
								$( this ).dialog( "close" );
							},
						}
					});
				
					
		$("#popup-content").load("?route=bm/bmvt17/view&id="+bmvt17id,function(){
			$("#popup").dialog("open");
		});	
	}
	
}
var bmvt16 = new BMVT16();
$(document).ready(function(e) {
    bmvt16.loadDotGiaoHang();
});
</script>