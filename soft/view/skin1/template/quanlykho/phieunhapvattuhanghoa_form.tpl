<div class="section" id="sitemaplist">

	<div class="section-title">Phiếu nhập vật tư hàng hóa</div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        <input type="hidden" name="phieunhapvattuhanghoaid" value="<?php echo $item['phieunhapvattuhanghoaid']?>">	
            <div class="button right">
                <a class="button save" onclick="phieu.save()">Lưu</a>
                <a class="button save" onclick="phieu.saveandprint()">Lưu & in</a>
                <a class="button cancel" href="?route=quanlykho/phieunhapvattuhanghoa">Bỏ qua</a>    
        	</div>
            <div class="clearer">&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>   
                
                <p class="left">
                    <label>Ngày lập</label><br />
                    <input type="text" name="ngaylap" value="<?php echo $this->date->formatMySQLDate($item['ngaylap'])?>" class="text ben-datepicker"/>
                    
                </p>
                <div class="clearer">&nbsp;</div>
                <p class="left">
                    <label>Kế hoạch đặt hàng số:</label><br />
                    <input type="text" id="kehoachdathang" name="kehoachdathang" value="<?php echo $item['kehoachdathang']?>" class="text" size=60 />
                </p>
                <p class="left">
                    <label>Ngày</label><br />
                    <input type="text" id="kehoachngay" name="kehoachngay" value="<?php echo $this->date->formatMySQLDate($item['kehoachngay'])?>" class="text ben-datepicker" size=60 />
                </p>
                <div class="clearer">&nbsp;</div>
                
                <p>
                	<label>Nhà cung cấp</label>
                    <select id="nhacungungid" name="nhacungungid">
                    	<option value=""></option>
                    	<?php foreach($data_nhacungung as $key => $val){ ?>
                        <option value="<?php echo $val['id']?>"><?php echo $val['tennhacungung']?> (<?php echo $val['manhacungung']?>)</option>
                        <?php } ?>
                    </select>
                </p>
                <p>
                	<label>Tình trạng</label>
                    <select id="tinhtrang" name="tinhtrang">
                    	<?php foreach($this->document->thanhtoan as $key => $val){ ?>
                        <option value="<?php echo $key?>"><?php echo $val?></option>
                        <?php } ?>
                    </select>
                </p>
            </div>
            <div>
            	<input type="button" class="button" id="btnThemDong" value="Thêm"/>
                <input type="button" class="button" id="btnXoaDong" value="Xóa"/>
                <input type="hidden" id="delchitietid" name="delchitietid" />
            	<table>
                	<thead>
                    	<tr>
                        	<th width="1%"><input type="checkbox" onclick="$('.chitietbn').attr('checked', this.checked);"></th>
                            <th>Mã nguyên liệu</th>
                            <th>Tên hàng - qui cách</th>
                            <th>Lot hàng</th>
                            <th>Đơn vị tính</th>
                            <th>Kho nhập</th>
                            <th>Chứng từ</th>
                            <th>Thực nhập</th>
                            <th>Đơn giá</th>
                            <th>Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody id="listnguyenlieu">
                    	
                    </tbody>
                   	<tfoot>
                    	<tr>
                        	<td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="text-right">Tông cộng</td>
                            <td class="number" id="total"></td>
                        </tr>
                    </tfoot>
                </table>
                
            </div>
        </form>
    
    </div>
    
</div>
<div style="display:none">
<?php foreach($data_chitiet as $ct){ ?>
	<div class="chitietphieu"><?php echo json_encode($ct)?></div>
<?php } ?>
</div>
<script language="javascript">
$('#nhacungungid').val("<?php echo $item['nhacungungid']?>");
$('#tinhtrang').val("<?php echo $item['tinhtrang']?>");
$(document).ready(function(e) {
    $('#btnThemDong').click(function(e) {
		var obj = new Object();
		obj.id = 0;
		obj.nguyenlieuid = 0;
		obj.manguyenlieu = '';
		obj.tennguyenlieu = '';
		obj.lotnguyenlieu = '';
		obj.donvi = '';
		obj.tendonvi = '';
		obj.chungtu = 0;
		obj.thucnhap = 0;
		obj.dongia = 0;
		obj.thanhtien = 0;
        phieu.addRow(obj);
    });
	$('.chitietphieu').each(function(index, element) {
        var obj = $.parseJSON($(this).html());
		phieu.addRow(obj)
    });
	
	$('#btnXoaDong').click(function(e) {
        $('.chitietid').each(function(index, element) {
			if(this.checked == true)
			{
				var pos = $(this).attr('ref');
				phieu.removeRow(pos);
			}
		});
    });
});

var auto = new AutoComplete();
function PhieuNhapVatTuHangHoa()
{
	this.index = 0;
	this.cbKhos = "<?php echo $cbKhos?>";
	this.addRow = function(obj)
	{
		var str ="";
		//Check box
		str+= '<td><input type="checkbox" class="chitietid" ref="'+ this.index +'" value="'+obj.id+'"><input type="hidden" id="id-'+this.index+'" name="id['+this.index+']" value="'+obj.id+'"></td>';
		//Ma nguyen lieu
		str+= '<td><input type="hidden" id="nguyenlieuid-'+ this.index +'" name="nguyenlieuid['+this.index+']" value="'+obj.nguyenlieuid+'"><input type="text" class="text gridautocomplete" id="manguyenlieu-'+ this.index +'" name="manguyenlieu['+this.index+']" value="'+obj.manguyenlieu+'"></td>';
		//Ten nguyen lieu
		str+= '<td><input type="text" class="text" id="tennguyenlieu-'+ this.index +'" name="tennguyenlieu['+this.index+']" value="'+obj.tennguyenlieu+'"></td>';
		//Lot nguuyen lieu
		str+= '<td><input type="text" class="text" id="lotnguyenlieu-'+ this.index +'" name="lotnguyenlieu['+this.index+']" value="'+obj.lotnguyenlieu+'"></td>';
		//Don vi tinh
		str+= '<td id="madonvi-'+this.index+'">'+obj.tendonvi+'</td>';
		//Kho nhap
		str+= '<td><select id="makho-'+this.index+'" name="makho['+this.index+']">'+this.cbKhos+'</select></td>';
		//Chung tu
		str+= '<td class="number"><input type="text" class="text number" id="chungtu-'+this.index+'" name="chungtu['+this.index+']" value="'+obj.chungtu+'"></td>';
		//Thuc nhap
		str+= '<td class="number"><input type="text" class="text number thucnhap" id="thucnhap-'+this.index+'" name="thucnhap['+this.index+']" value="'+obj.thucnhap+'" ref="'+this.index+'"></td>';
		//Don gia
		str+= '<td class="number"><input type="text" class="text number dongia" id="dongia-'+this.index+'" name="dongia['+this.index+']" value="'+obj.dongia+'" ref="'+this.index+'"></td>';
		//Thanh tien
		str+= '<td class="number thanhtien" id="thanhtien-'+this.index+'">'+formateNumber(obj.thanhtien)+'</td>';
		
		var row = '<tr id="row-'+this.index+'">'+str+'</tr>';
		
		$('#listnguyenlieu').append(row);
		$('#makho-'+this.index).val(obj.makho);
		this.index++;
		numberReady();
		this.getTotal();
		auto.autocomplete();
		$('.thucnhap').keyup(function(e) {
			pos = $(this).attr('ref');
            $('#thanhtien-'+pos).html(formateNumber(phieu.getSubTotal(pos)));
			phieu.getTotal();
			
        });
		$('.dongia').keyup(function(e) {
            pos = $(this).attr('ref');
            $('#thanhtien-'+pos).html(formateNumber(phieu.getSubTotal(pos)));
			phieu.getTotal();
        });
		
	}
	
	this.removeRow = function(pos)
	{
		var id = $('#id-'+pos).val();
		$('#delchitietid').val($('#delchitietid').val()+","+id);
		$('#row-'+pos).remove();
	}
	this.getSubTotal = function(pos)
	{
		var thucnhap = $('#thucnhap-'+pos).val().replace(/,/g,"");
		var dongia = $('#dongia-'+pos).val().replace(/,/g,"");
		return Number(thucnhap)*Number(dongia);
	}
	this.getTotal = function()
	{
		sum = 0;
		$('.thanhtien').each(function(index, element) {
        	var num = String($(this).html()).replace(/,/g,"");
			sum += Number(num);
    	});
		$('#total').html(formateNumber(sum));
	}
	
	this.save =function()
	{
		$.blockUI({ message: "<h1>Please wait...</h1>" }); 
		
		$.post("?route=quanlykho/phieunhapvattuhanghoa/save", $("#frm").serialize(),
			function(data){
				var obj = $.parseJSON(data);
				if(obj.error == "")
				{
					window.location = "?route=quanlykho/phieunhapvattuhanghoa";
				}
				else
				{
				
					$('#error').html(obj.error).show('slow');
					
					
				}
				$.unblockUI();
				
			}
		);
	}
	this.saveandprint =function()
	{
		$.blockUI({ message: "<h1>Please wait...</h1>" }); 
		
		$.post("?route=quanlykho/phieunhapvattuhanghoa/save", $("#frm").serialize(),
			function(data){
				var obj = $.parseJSON(data);
				if(obj.error == "")
				{
					openDialog("?route=quanlykho/phieunhapvattuhanghoa/view&phieunhapvattuhanghoaid="+obj.phieunhapvattuhanghoaid+"&dialog=print",800,500);
					//window.location = "?route=quanlykho/phieunhapvattuhanghoa/view&phieunhapvattuhanghoaid="+obj.phieunhapvattuhanghoaid+"&dialog=print";
					//$('#ifprint').attr('src',"?route=quanlykho/phieunhapvattuhanghoa/view&phieunhapvattuhanghoaid="+obj.phieunhapvattuhanghoaid+"&dialog=print");
					window.location = "?route=quanlykho/phieunhapvattuhanghoa";
				}
				else
				{
				
					$('#error').html(obj.error).show('slow');
					
					
				}
				$.unblockUI();
				
			}
		);
	}
}
var phieu = new PhieuNhapVatTuHangHoa();

function callBackAutoComplete(val)
{
	getNguyenLieu("manguyenlieu",val.value,"like");
}


function getNguyenLieu(col,val,operator)
{
	$.getJSON("?route=quanlykho/nguyenlieu/getNguyenLieu&col="+col+"&val="+val+"&operator="+operator, 
			function(data) 
			{
				str = "";
				for( i in data.nguyenlieus)
				{
					str+= '<li id=rowauto-'+i+' class=autocompleterow>'+ data.nguyenlieus[i].manguyenlieu + ':' +data.nguyenlieus[i].tennguyenlieu+'</li><input type="hidden" id="idnguyenlieu-'+i+'" value="'+ data.nguyenlieus[i].id +'" />';
				}
				$("#autocomplete").html("<ul class='autocomplete'>"+str+"</ul>");
				auto.selectRow();
			});
}

function selectValue(eid)
{
	str = auto.getValue();
	arr = str.split(":");
	
	$("#"+eid).val(arr[0]);
	$.getJSON("?route=quanlykho/nguyenlieu/getNguyenLieu&col=manguyenlieu&val="+arr[0]+"&operator=", 
			function(data) 
			{
				
				ar = eid.split("-");
				pos = ar[1];
				for( i in data.nguyenlieus)
				{
					$("#manguyenlieu-"+pos).val(data.nguyenlieus[i].manguyenlieu);
					$("#tennguyenlieu-"+pos).val(data.nguyenlieus[i].tennguyenlieu);
					$("#nguyenlieuid-"+pos).val(data.nguyenlieus[i].id);
					$("#madonvi-"+pos).html(data.nguyenlieus[i].tendonvitinh);
					$('#makho-'+pos).val(data.nguyenlieus[i].makho);
				}
				
			});
	auto.closeAutocomplete()
}



</script>
<iframe id="ifprint"></iframe>