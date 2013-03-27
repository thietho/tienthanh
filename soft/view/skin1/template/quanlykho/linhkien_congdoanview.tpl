<div class="section" id="sitemaplist">
	<div class="section-title"><?php echo $this->document->title?></div>
	<div>Quá trinh thay đổi công doan <?php echo $logcongdoan[0]->macongdoan?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	
            <div class="clearer">^&nbsp;</div>
        	
        	<div>
               	
                <table>
                	<thead>
                		<tr>
                        	<!--<th>Mã công đoạn</th>-->
                            <th>Tên công đoạn</th>
                            <th>Thứ tự công đoạn</th>
                            <th>Nguyên liệu sản xuất</th>
                            <th>Thiết bị sản xuất</th>
                            <th>Định mức chỉ tiêu</th>
                            <th>Giá gia công</th>
                            <th>Định mức phế liệu</th>
                            <th>Định mức phế phẩm</th>
                            <th>Định mức hao hụt</th>
                            <th>Định mức năng xuất</th>
                            <th>Định mức phụ liệu</th>
                            <th>Số lượng/Kg</th>
                            <th>Ghi chú</th>
                            <th></th>
                    	</tr>
                    </thead>
                    <tbody id="listcongdoan">
                    	<?php if(count($logcongdoan)){?>
                    	<?php foreach($logcongdoan as $item){ ?>
                        <tr>
                        	<!--<td><?php echo $item->macongdoan?></td>-->
                            <td><?php echo $item->tencongdoan?></td>
                            <td class="number"><?php echo $item->thututhuchien?></td>
                            <td><?php echo $item->tennguyenlieusanxuat?></td>
                            <td><?php echo $item->tenthietbisanxuatchinh?></td>
                            <td class="number"><?php echo $item->dinhmucchitieu?></td>
                            <td class="number"><?php echo $item->giagiacong?></td>
                            <td class="number"><?php echo $item->dinhmucphelieu?></td>
                            <td class="number"><?php echo $item->dinhmucphepham?></td>
                            <td class="number"><?php echo $item->dinhmuchaohut?></td>
                            <td class="number"><?php echo $item->dinhmucnangxuat?></td>
                            <td class="number"><?php echo $item->dinhmucphulieu?></td>
                            <td class="number"><?php echo $item->soluongtrenkg?></td>
                            <td><?php echo $item->ghichu?></td>
                            <td><?php echo $this->date->formatMySQLDate($item->logdate,"longdate")?></td>
                    	</tr>
                        <?php } ?>
                        <?php } ?>
                    </tbody>
                </table>
               
            </div>
           
        </form>
    
    </div>
    
</div>