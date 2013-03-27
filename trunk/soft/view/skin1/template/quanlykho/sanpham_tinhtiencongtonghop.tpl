<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	
     	        <input type="button" value="Cancel" class="button" onclick="linkto('?route=quanlykho/sanpham')"/>   
     	        <input type="hidden" name="masanpham" value="<?php echo $item['id']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<p>
            		<label>Mã sản phẩm: <?php echo $item['masanpham']?></label>
            	</p>
              	
                
                <p>
            		<label>Tên sản phẩm: <?php echo $item['tensanpham']?></label>
            	</p>
               	<p>
                	<label>Tiền công tổng hợp</label>
                    <table style="width:auto">
                        	<thead>
                                <tr>
                                    <th>Nguyên liệu</th>
                                    <th>Số lượng</th>
                                    <th>Đơn vị</th>
                                    <th>Tiền công của 1 linh kiện</th>
                                    <th>Thành tiền</th>
                                </tr>
                            </thead>
                            <tbody id="dinhluonglinhkien">
                            	<?php 
                                $sum = 0;
                                foreach($dinhluong as $item)
                                { 
                                	
                                ?>
                                <tr>
                                	<td><?php echo $this->document->getLinhKien($item['malinhkien'])?></td>
                                    <td class="number"><?php echo $item['soluong']?></td>
                                    <td><?php echo $this->document->getTenDonVi($this->document->getLinhKien($item['malinhkien'],"madonvi"))?></td>
                                    <td class="number"><?php echo $this->string->numberFormate($item['tiencong'])?></td>
                                    <td class="number"><?php echo $this->string->numberFormate($item['tiencong']*$item['soluong'])?></td>
                                </tr>
                                <?php 
                                	$sum += $item['tiencong']*$item['soluong'];
                                } 
                                ?>
                            </tbody>
                            <tfoot>
                            	<td></td>
                                <td></td>
                                <td></td>
                                <td>Tổng cộng</td>
                                <td class="number"><?php echo $this->string->numberFormate($sum)?></td>
                            </tfoot>
                        </table>
                </p>
                
               
               
               
            </div>
            
        </form>
    
    </div>
    
</div>

