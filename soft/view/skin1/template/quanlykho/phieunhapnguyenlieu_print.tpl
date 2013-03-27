<style>
.number
{
	text-align:right;
}
</style>

<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">

            <div id="container">
                
    
                <div id="fragment-phieunhapnguyenlieu" class="tabs-container">   
                    <?php if($item['maphieu']!=""){ ?>
                    <p>
                        <label>Số chứng từ</label>: <?php echo $item['maphieu']?>
                        
                        
                    </p>
                    <?php } ?>
                    <p>
                        <label>Người giao</label>: <?php echo $item['nguoigiao'] ?>
                        
                    </p>   
                    
                    <p>
                        <label>Loại nguồn</label>: <?php echo $this->document->loainguon[$item['loainguon']] ?>
                        
                        
                    </p>
                    
                    <p>
                        <label>Mã phiếu nguồn</label>: <?php echo $item['maphieunguon'] ?>
                        
                       
                    </p>   
                    
                    <p id="rowkho">
                    	<label>Nhập vào kho</label>: <?php echo $this->document->getTenNhom($item['makho']) ?>
                        
                        
                    </p>
                    
                    <p>
                        <label>Ngày nhập</label>: <?php echo $this->date->formatMySQLDate($item['ngaynhap'])?> <?php echo $this->date->getTime($item['ngaynhap'])?>
                    </p>
                    
                    <p>
                        <label>Mã hợp đồng</label>: <?php echo $item['mahopdong']?>
                    </p>
                    
                    <p>
                        <label>Ngày lập phiếu</label> :<?php echo $this->date->formatMySQLDate($item['ngaylapphieu'])?>
                    </p>
                    
                    <p>
                        <label>Ngày in phiếu</label> :<?php echo $this->date->formatMySQLDate($this->date->getToday())?> <?php echo $this->date->getTime($this->date->getToday())?> 
                    </p>
                    
                    <p>
                        <label>Nhân viên lập phiếu</label>: <?php echo $item['tennguoilap'] ?>
                    </p>
                    
                    <p>
                        <label>Tình trạng phiếu</label>: <?php echo $this->document->thanhtoan[$item['tinhtrang']] ?>
                       
                    </p>
                  	<p>
                    	<label>Ghi chú</label>: <?php echo $item['ghichu'] ?>
                    </p>
                </div>
                
                <!-- chi tiet phieu nhap nguyen lieu -->
                <div id="fragment-chitietphieunhapnguyenlieu" class="tabs-container">
                	
                    <p>
                        
                            <input type="hidden" id="manguyenlieu" name="manguyenlieu">
                            <table style="width:auto">
                                <thead>
                                    <tr>
                                    	<th>Mã tem</th>
                                        <th>Mã nguyên vật liệu</th>
                                        <th>Tên nguyên vật liệu</th>
                                        <th>Số lượng</th>
                                        <th>Đơn giá</th>
                                        <th>Đơn vị tính</th>
                                        <th>Thực nhập</th>
                                        <th>Bao bì</th>
                                        <th>Ghi chú</th>
                                       
                                    </tr>
                                </thead>
                                <tbody id="chitiet">
                                    <?php foreach($chitiet as $key => $val){ ?>
                                    <tr>
                                    	<td><?php echo $val['id']?></td>
                                        <td><?php echo $this->document->getNguyenLieu($val['itemid'])?></td>
                                        <td><?php echo $val['itemname']?></td>
                                        <td class="number"><?php echo $this->string->numberFormate($val['soluong'],0)?></td>
                                        <td class="number"><?php echo $this->string->numberFormate($val['dongia'],0)?></td>
                                        <td><?php echo $this->document->getDonViTinh($val['madonvi'])?></td>
                                        <td class="number"><?php echo $this->string->numberFormate($val['thucnhap'],0)?></td>
                                        <td class="number"><?php echo $this->string->numberFormate($val['baobi'],0)?></td>
                                        <td><?php echo $val['ghichu']?></td>
                                        
                                    </tr>
                                    <?php } ?>
                                </tbody>
                            </table>
                            <input type="hidden" id="delchitiet" name="delchitiet" />
                    </p>
                
                </div>
                <!-- end chi tiet phieu nhan hang -->
                
            </div>
        </form>
    
    </div>
    
</div>


<script language="javascript">
	window.print();
</script>
