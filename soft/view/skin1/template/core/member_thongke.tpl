<table id="reportbanhang" class="data-table">
	<thead>
        <tr>
        	
        	<th>Mã phiếu</th>
            <th>Khách hàng</th>
            <th>Điện thoại</th>
            <th>Địa chỉ</th>
            <th>Giá trị đơn hàng</th>
        </tr>
    </thead>
    <tbody>
    	<?php $sum = 0;?>
        <?php $sumcommissions = 0;?>
    	<?php foreach($data_banhang as $memberid => $banhang){ ?>
        <?php $commissions= $this->document->getCustomer($memberid,'commissions')?>
        <tr>
        	<td colspan="4"><strong><?php echo $this->document->getCustomer($memberid)?> <?php echo $this->document->getCustomer($memberid,'phone')?> <?php echo $this->document->getCustomer($memberid,'address')?> <?php echo $commissions?></strong></td>
            <?php $su = 0;?>
            <?php foreach($banhang as $item) { ?>
            <?php $su += $item['tongtien']?>
            <?php } ?>
            <?php $sumcommissions += $su*$commissions/100 ?>
            <td class="number"><strong><?php echo $this->string->numberFormate($su)?></strong></td>
        </tr>
        	<?php foreach($banhang as $item) { ?>
        	<?php $sum += $item['tongtien']?>
        <tr>
        	
        	<td><a onclick="objdl.viewPX(<?php echo $item['phieuid']?>,'')"><?php echo $item['maphieu']?></a></td>
        	
            
            <td><?php echo $item['tenkhachhang']?></td>
            <td><?php echo $item['dienthoai']?></td>
            <td><?php echo $item['diachi']?></td>
            <td class="number"><?php echo $this->string->numberFormate($item['tongtien'])?></td>
        </tr>
        	<?php } ?>
        <?php } ?>
        <tr>
            <td class="number" colspan="4">Tổng cộng</td>
            <td class="number"><?php echo $this->string->numberFormate($sum)?></td>
        </tr>
        <tr>
            <td class="number" colspan="4">Hoa hồng</td>
            <td class="number"><?php echo $sumcommissions?></td>
        </tr>
        <tr>
            <td class="number" colspan="4">Công nợ hiện tại</td>
            <td class="number"><?php echo $this->string->numberFormate($congno)?></td>
        </tr>
        <tr>
            <td class="number" colspan="4">Thanh toán hoa hồng</td>
            <td class="number"><?php echo $this->string->numberFormate($congno - $sumcommissions)?></td>
        </tr>
    </tbody>
</table>