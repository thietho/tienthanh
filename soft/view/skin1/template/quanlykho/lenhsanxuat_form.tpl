<div class="section" id="sitemaplist">

	<div class="section-title">Lệnh sản xuất</div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        <input type="hidden" name="lenhsanxuatid" value="<?php echo $item['lenhsanxuatid']?>">	
        <input type="hidden" id="selectnhanvien">
        <input type="hidden" id="selectsanpham">
        <input type="hidden" id="selectmalinhkien">
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
                	<label>Loại sản xuất</label>
                    <select name="loaisx" id="loaisx">
                    	<option value="sxlk">Sản xuất linh kiện</option>
                        <option value="sxsp">Sản xuất sản phẩm</option>
                    </select>
                	<label>Sản phẩm SX:</label>
                    <input type="hidden" id="sanphamid" name="sanphamid" value="<?php echo $item['sanphamid']?>">
                    <input type="hidden" id="masanpham" name="masanpham" value="<?php echo $item['masanpham']?>">
                    <input type="hidden" id="tensanpham" name="tensanpham" value="<?php echo $item['tensanpham']?>">
                    <span id="sanpham_text"><?php echo $item['tensanpham']?></span>
                    <input type="button" class="button" id="btnChonSanPham" value="Chọn sản phẩm">
                	
                    <label>Lot SP</label>
                    <input type="text" id="lotsp" name="lotsp" value="<?php echo $item['lotsp']?>" class="text"/>
               </p>
               <p>
               		<label>Số Lot SX:</label>
                    <input type="text" id="solotsx" name="solotsx" value="<?php echo $item['solotsx']?>" class="text number"/>
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
                    	<?php foreach($this->document->thuchien as $key => $val){ ?>
                        <option value="<?php echo $key?>"><?php echo $val?></option>
                        <?php } ?>
                    </select>
                </p>
                
            </div>
            
        </form>
    
    </div>
    
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
$('#btnChonSanPham').click(function(e) {
    if($('#loaisx').val()=="sxlk")
	{
		chonLinhKien();
	}
	else
	{
		chonSanPham();
	}
});
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
function chonLinhKien()
{
	openDialog("?route=quanlykho/linhkien&opendialog=true",800,500);
	var listlinhkien = $('#selectmalinhkien').val().split(',');
	for(i in listlinhkien )
	{
		if(listlinhkien[i]!="")
		{
			$.getJSON('?route=quanlykho/linhkien/getLinhKien&col=id&val='+listlinhkien[i],function(data){
				for(i in data.linhkiens)
				{	
					$('#sanphamid').val(data.linhkiens[i].id);
					$('#tensanpham').val(data.linhkiens[i].tenlinhkien);
					$('#masanpham').val(data.linhkiens[i].malinhkien);
					$('#sanpham_text').html(data.linhkiens[i].tenlinhkien);
					
				}
			});
		}
		
	}
}

$(document).ready(function(e) {
    
});


</script>
<iframe id="ifprint"></iframe>