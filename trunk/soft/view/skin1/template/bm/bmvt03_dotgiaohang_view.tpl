

	
	<input type="hidden" name="bmvt03id" value="<?php echo $item['id']?>">
	<p>
    	Lô hàng theo phiếu giao hàng số:
        <?php echo $item['sophieugiaohang']?>
        Ngày:
        <?php echo $this->date->formatMySQLDate($item['ngayphieugiaohang'])?>
        
    </p>
    <p>
    	Công ty:
        
        <span id="tennhacungcapview"><strong><?php echo $item['tennhacungung']?></strong></span>
        Theo kế hoạch đặt hàng số
        <?php echo $item['sokehoachdathang']?>
        Ngày:
        <?php echo $this->date->formatMySQLDate($item['ngaykehoachdathang'])?>
    </p>
    <table class="table-data">
	<thead>
        <tr>
            <th>STT</th>
            <th>Tên hàng và qui cách</th>
            <th>ĐVT</th>
            
            <th>Số lượng giao</th>
            
            
        </tr>
       
        
    </thead>
    <tbody>
    	<?php if(count($data_ct)){ ?>
			<?php foreach($data_ct as $key => $ct){ ?>
    	<tr>
        	<td><?php echo $key + 1 ?></td>
            <td>
            	
            	<?php echo $ct['itemname']?>
            </td>
            <td><?php echo $this->document->getDonViTinh($ct['madonvi'])?></td>
            
            <td class="number"><?php echo $this->string->numberFormate($ct['soluong'])?></td>
            
            
        </tr>
        	<?php } ?>
        <?php } ?>
    </tbody>
   
</table>

