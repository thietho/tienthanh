<div class="section" id="sitemaplist">

	<div class="section-title">Lệnh sản xuất</div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        <input type="hidden" name="lenhsanxuatid" value="<?php echo $item['lenhsanxuatid']?>">	
        <input type="hidden" id="selectnhanvien">
        <input type="hidden" id="selectsanpham">
            <div class="button right">
                <a class="button save" onclick="phieu.save()">Lưu</a>
                <a class="button save" onclick="phieu.saveandprint()">Lưu & in</a>
                <a class="button cancel" href="?route=quanlykho/phieunhapvattuhanghoa">Bỏ qua</a>    
        	</div>
            <div class="clearer">&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>   
                
                <p>
                    <label>Ngày lập</label><br />
                    <input type="text" name="ngaylap" value="<?php echo $this->date->formatMySQLDate($item['ngaylap'])?>" class="text ben-datepicker"/>
                    
                </p>
                <p>
                	<label>Phòng ban nhận lệnh</label>
                    <select id="phongbannhan" name="phongbannhan">
                    	<option value=""></option>
                    	<?php echo $cbPhongBang?>
                    </select>
                </p>
                <p>
                    <label>Nhân viên:</label>
                    <input type="hidden" id="nhanvien" name="nhanvien" value="<?php echo $item['nhanvien']?>">
                    <span id="tennhanvien"><?php echo $this->document->getNhanVien($item['nhanvien'])?></span>
                    <input type="button" class="button" id="btnChonNhanVien" value="Chọn nhân viên" onClick="chonNhanVien('nhanvien','tennhanvien')">
                	
                    <label>KTV phụ trách:</label>
                    <input type="hidden" id="ktvien" name="ktvien" value="<?php echo $item['ktvien']?>">
                    <span id="tenktvien"><?php echo $this->document->getNhanVien($item['ktvien'])?></span>
                    <input type="button" class="button" id="btnChonKTVien" value="Chọn KT viên" onClick="chonNhanVien('ktvien','tenktvien')">
                
                    <label>Phụ trách chính:</label>
                    <input type="hidden" id="phutrachchinh" name="phutrachchinh" value="<?php echo $item['phutrachchinh']?>">
                    <span id="tenphutrachchinh"><?php echo $this->document->getNhanVien($item['phutrachchinh'])?></span>
                    <input type="button" class="button" id="btnChonPhuTrachChinh" value="Chọn phụ trách chính" onClick="chonNhanVien('phutrachchinh','tenphutrachchinh')">
                </p>
                
                <p>
                	<label>Sản phẩm SX:</label>
                    <input type="hidden" id="sanphamid" name="sanphamid" value="<?php echo $item['sanphamid']?>">
                    <input type="hidden" id="masanpham" name="masanpham" value="<?php echo $item['masanpham']?>">
                    <input type="hidden" id="tensanpham" name="tensanpham" value="<?php echo $item['tensanpham']?>">
                    <span id="sanpham_text"><?php echo $item['tensanpham']?></span>
                    <input type="button" class="button" id="btnChonSanPham" value="Chọn sản phẩm" onClick="chonSanPham()">
                
                	<label>T/lượng SX:</label>
                    <input type="text" id="trongluongsx" name="trongluongsx" value="<?php echo $item['trongluongsx']?>" class="text number"/>
                </p>
               
                <p>
                	<label>Quyết định giá số:</label>
                    <input type="text" id="qdgiaso" name="qdgiaso" class="text" value="<?php $item['qdgiaso']?>">
                
                    <label>Ngày</label>
                    <input type="text" id="ngayqdg" name="ngayqdg" value="<?php echo $this->date->formatMySQLDate($item['ngayqdg'])?>" class="text ben-datepicker"/>
                    
                </p>
                <p>
                	<label>Phiếu CAR số:</label>
                    <input type="text" id="phieucarso" name="phieucarso" class="text" value="<?php $item['phieucarso']?>">
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
                            <th>Linh kiện</th>
                            <th>Tên linh kiện</th>
                            <th>Tên chi tiết / công đoạn</th>
                            <th>Nguyên liệu</th>
                            <th>Lot NL</th>
                            <th>BM-SX-01 số</th>
                            <th>SL</th>
                            <th>Đơn giá</th>
                            <th>Thành phẩm</th>
                            <th>Phế liệu</th>
                            <th>Phế phẩm</th>
                            <th>Năng suất</th>
                        </tr>
                    </thead>
                    <tbody id="listcongdoan">
                    	
                    </tbody>
                   	
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
function chonNhanVien(eid,tenview)
{
	openDialog("?route=quanlykho/nhanvien&opendialog=true",800,500);
	var listnhanvien = $('#selectnhanvien').val().split(',');
	for(i in listnhanvien )
	{
		if(listnhanvien[i]!="")
		{
			$.getJSON('?route=quanlykho/nhanvien/getNhanVien&col=id&val='+listnhanvien[i],function(data){
				for(i in data.nhanviens)
				{
					$('#'+eid).val(data.nhanviens[i].id);	
					$('#'+tenview).html(data.nhanviens[i].hoten);	
					
				}
			});
		}
		
	}
}

function chonSanPham()
{
	openDialog("?route=quanlykho/sanpham&opendialog=true",800,500);
	var listsanpham = $('#selectsanpham').val().split(',');
	for(i in listsanpham )
	{
		if(listsanpham[i]!="")
		{
			$.getJSON('?route=quanlykho/sanpham/getSanPham&col=id&val='+listsanpham[i],function(data){
				for(i in data.sanphams)
				{
					
					$('#sanphamid').val(data.sanphams[i].id);
					$('#tensanpham').val(data.sanphams[i].tensanpham);
					$('#masanpham').val(data.sanphams[i].masanpham);
					$('#sanpham_text').html(data.sanphams[i].tensanpham);
				}
			});
		}
		
	}
}

$(document).ready(function(e) {
    $('#btnThemDong').click(function(e) {
		var obj = new Object();
		obj.id = 0;
		obj.linhkiendid = 0,
		obj.malinhkien = "",
		obj.tenlinhkien = "",
		obj.nguyenlieuid = 0;
		obj.manguyenlieu = '';
		obj.tennguyenlieu = '';
		obj.congdoanid = 0;
		obj.lotnguyenlieu = '';
		obj.bmsx01so = '';
		obj.soluong = 0;
		obj.dongia = 0;
		obj.chitieutp = 0;
		obj.chitieupl = 0;
		obj.chitieupp = 0;
		obj.nangsuat = 0;
        lsx.addRow(obj);
    });
	$('.chitietphieu').each(function(index, element) {
        var obj = $.parseJSON($(this).html());
		lsx.addRow(obj)
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
function LenhSanXuat()
{
	this.index = 0;
	this.cbKhos = "<?php echo $cbKhos?>";
	this.addRow = function(obj)
	{
		var str ="";
		//Check box
		str+= '<td><input type="checkbox" class="chitietid" ref="'+ this.index +'" value="'+obj.id+'"><input type="hidden" id="id-'+this.index+'" name="id['+this.index+']" value="'+obj.id+'"></td>';
		//Ma linh kien
		str+= '<td><input type="hidden" id="linhkienid-'+ this.index +'" name="linhkienid['+this.index+']" value="'+obj.linhkienid+'"><input type="text" class="text gridautocomplete" id="malinhkien-'+ this.index +'" name="malinhkien['+this.index+']" value="'+obj.malinhkien+'"></td>';
		//Ten linh kien
		str+= '<td><input type="text" class="text" id="tenlinhkien-'+ this.index +'" name="tenlinhkien['+this.index+']" value="'+obj.tenlinhkien+'"></td>';
		//Ten chi tiet cong doan
		str+= '<td><select id="congdoanid-'+ this.index +'" name="congdoanid['+this.index+']"></select></td>';
		//Ten nguyen lieu
		str+= '<td><input type="hidden" id="nguyenlieuid-'+ this.index +'" name="nguyenlieuid['+this.index+']" value="'+obj.nguyenlieuid+'"><input type="hidden" id="manguyenlieu-'+ this.index +'" name="manguyenlieu['+this.index+']" value="'+obj.manguyenlieu+'"><input type="hidden" id="tennguyenlieu-'+ this.index +'" name="tennguyenlieu['+this.index+']" value="'+obj.tennguyenlieu+'"><span id="tennguyenlieutext-'+this.index+'"></span></td>';
		//Lot nguuyen lieu
		str+= '<td><input type="text" class="text" id="lotnguyenlieu-'+ this.index +'" name="lotnguyenlieu['+this.index+']" value="'+obj.lotnguyenlieu+'"></td>';
		//BM-SX-01 so
		str+= '<td><input type="text" class="text" id="bmsx01so-'+ this.index +'" name="bmsx01so['+this.index+']" value="'+obj.bmsx01so+'"></td>';
		//So luong
		str+= '<td class="number"><input type="text" class="text number" id="soluong-'+this.index+'" name="soluong['+this.index+']" value="'+obj.soluong+'"></td>';
		//Don gia
		str+= '<td class="number"><input type="text" class="text number" id="dongia-'+this.index+'" name="dongia['+this.index+']" value="'+obj.dongia+'" ref="'+this.index+'"></td>';
		//Phành phẩm
		str+= '<td class="number"><input type="text" class="text number" id="chitieutp-'+this.index+'" name="chitieutp['+this.index+']" value="'+obj.chitieutp+'" ref="'+this.index+'"></td>';
		//Phế liệu
		str+= '<td class="number"><input type="text" class="text number" id="chitieupl-'+this.index+'" name="chitieupl['+this.index+']" value="'+obj.chitieupl+'" ref="'+this.index+'"></td>';
		//Phế phẩm
		str+= '<td class="number"><input type="text" class="text number" id="chitieupp-'+this.index+'" name="chitieupp['+this.index+']" value="'+obj.chitieupp+'" ref="'+this.index+'"></td>';
		//Nang suat
		str+= '<td class="number"><input type="text" class="text number" id="nangsuat-'+this.index+'" name="nangsuat['+this.index+']" value="'+obj.nangsuat+'" ref="'+this.index+'"></td>';
		
		var row = '<tr id="row-'+this.index+'">'+str+'</tr>';
		
		$('#listcongdoan').append(row);
		this.index++;
		numberReady();
		auto.autocomplete();
	}
	
	this.removeRow = function(pos)
	{
		var id = $('#id-'+pos).val();
		$('#delchitietid').val($('#delchitietid').val()+","+id);
		$('#row-'+pos).remove();
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
					openDialog("?route=quanlykho/phieunhapvattuhanghoa/view&lenhsanxuatid="+obj.lenhsanxuatid+"&dialog=print",800,500);
					//window.location = "?route=quanlykho/phieunhapvattuhanghoa/view&lenhsanxuatid="+obj.lenhsanxuatid+"&dialog=print";
					//$('#ifprint').attr('src',"?route=quanlykho/phieunhapvattuhanghoa/view&lenhsanxuatid="+obj.lenhsanxuatid+"&dialog=print");
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
var lsx = new LenhSanXuat();

function callBackAutoComplete(val)
{
	getLinhKien("malinhkien",val.value,"like");
}


function getLinhKien(col,val,operator)
{
	
	$.getJSON("?route=quanlykho/linhkien/getLinhKien&col="+col+"&val="+val+"&operator="+operator, 
			function(data) 
			{
				str = "";
				for( i in data.linhkiens)
				{
					str+= '<li id=rowauto-'+i+' class=autocompleterow>'+ data.linhkiens[i].malinhkien + ':' +data.linhkiens[i].tenlinhkien+'</li><input type="hidden" id="idnguyenlieu-'+i+'" value="'+ data.linhkiens[i].id +'" />';
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
	$.getJSON("?route=quanlykho/linhkien/getLinhKien&col=malinhkien&val="+arr[0]+"&operator=", 
			function(data) 
			{
				
				ar = eid.split("-");
				pos = ar[1];
				for( i in data.linhkiens)
				{
					$("#malinhkien-"+pos).val(data.linhkiens[i].malinhkien);
					$("#tenlinhkien-"+pos).val(data.linhkiens[i].tenlinhkien);
					$("#linhkienid-"+pos).val(data.linhkiens[i].id);
					//Lay nguyen lien su dung
					$.getJSON("?route=quanlykho/nguyenlieu/getNguyenLieu&col=id&val="+data.linhkiens[i].nguyenlieusudung,function(nguyenlieu){
						for(i in nguyenlieu.nguyenlieus)
						{
							$('#nguyenlieuid-'+pos).val(nguyenlieu.nguyenlieus[i].id);
							$('#manguyenlieu-'+pos).val(nguyenlieu.nguyenlieus[i].manguyenlieu);	
							$('#tennguyenlieu-'+pos).val(nguyenlieu.nguyenlieus[i].tennguyenlieu);
							$('#tennguyenlieutext-'+pos).html(nguyenlieu.nguyenlieus[i].tennguyenlieu);
						}
					});
					//Lay cac cong doan cua linh kien vua duoc chon
					$.getJSON("?route=quanlykho/congdoan/getCongDoan&col=malinhkien&val="+data.linhkiens[i].id,function(congdoan){
						var str = "";
						for(i in congdoan.congdoans)
						{
							str += '<option value="'+congdoan.congdoans[i].id+'">'+ congdoan.congdoans[i].macongdoan + ' - ' + congdoan.congdoans[i].tencongdoan+'</option>';
							
						}
						$('#congdoanid-'+pos).html(str);
					});
				}
				
			});
	auto.closeAutocomplete()
}



</script>
<iframe id="ifprint"></iframe>