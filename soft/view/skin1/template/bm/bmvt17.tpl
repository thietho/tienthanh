<table class="table-data">
	<tr>
    	<td width="80px"><img src="<?php echo DIR_IMAGE?>logotienthanh.png" width="80px"></td>
      	<td align="center">
        	<h2>PHIẾU CÂN HÀNG</h2>
	        <p>Ngày <?php echo $this->date->getDay($item['ngaylap'])?> tháng <?php echo $this->date->getMonth($item['ngaylap'])?> năm <?php echo $this->date->getYear($item['ngaylap'])?></p>
      	</td>
      	<td width="180px">
            <p>Mã hiệu: BM-VT-17</p>
            <p>Lần phát hành: 01</p>
            <p>Lần sửa đổi: 00</p>
            <p>Ngày phát hành: 09/06/08</p>
            <p>Số: <?php echo $item['sophieu']?></p>
      	</td>
    </tr>
</table>
<p>
	Đơn vị giao hàng: <?php echo $item['tennhacungung']?>
</p>

<table class="table-data">
	<thead>
        <tr>
            <th>STT</th>
            <th>Tên hàng</th>
            <th>Bao bì</th>
            <th>Loại bao</th>
            <th>Số lượng</th>
            <th>ĐVT</th>
            <th>Ghi chú</th>
        </tr>
        
    </thead>
    <tbody>
    	<?php if(count($data_ct)){ ?>
			<?php foreach($data_ct as $key => $ct){ ?>
    	<tr>
        	<td><?php echo $key + 1 ?></td>
            <td><?php echo $ct['itemname']?></td>
            <td><?php echo $ct['baobi']?></td>
            <td><?php echo $ct['loaibao']?></td>
            <td class="number"><?php echo $this->string->numberFormate($ct['soluongcan'])?></td>
            <td class="number"><?php echo $this->document->getDonViTinh($ct['madonvi'])?></td>
            <td><?php echo $ct['ghichu']?></td>
        </tr>
        	<?php } ?>
        <?php } ?>
    </tbody>
   
</table>

<table>
	<tr>
    	<th width="33%"></th>
        <th width="33%"></th>
       
        <th width="33%">Thủ kho</th>
    </tr>
</table>
<script language="javascript">
window.print();
</script>