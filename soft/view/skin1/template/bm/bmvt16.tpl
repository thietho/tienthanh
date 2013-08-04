<table class="table-data">
	<tr>
    	<td width="80px"><img src="<?php echo DIR_IMAGE?>logotienthanh.png" width="80px"></td>
      	<td align="center">
        	<h2>PHIẾU NHẬP VẬT TƯ HÀNG HÓA</h2>
	        <p>Ngày <?php echo $this->date->getDay($item['ngaylapphieu'])?> tháng <?php echo $this->date->getMonth($item['ngaylapphieu'])?> năm <?php echo $this->date->getYear($item['ngaylapphieu'])?></p>
      	</td>
      	<td width="180px">
            <p>Mã hiệu: BM-VT-16</p>
            <p>Lần phát hành: 01</p>
            <p>Lần sửa đổi: 00</p>
            <p>Ngày phát hành: 25/05/08</p>
            <p>Số: <?php echo $item['sophieu']?></p>
      	</td>
    </tr>
</table>
<table style="margin:10px 0;">
	<tr>
   	  <td>KH đặt hàng số: <?php echo $item['sokehoachdathang']?></td>
        <td>Ngày: <?php echo $this->date->formatMySQLDate($item['ngaykehoachdathang'])?></td>
        
    </tr>
</table>
<table class="table-data">
	<thead>
        <tr>
            <th rowspan="2">STT</th>
            <th rowspan="2">Tên hàng - qui cách</th>
            <th rowspan="2">Lot hàng</th>
            <th rowspan="2">Đ/V<br />tính</th>
            <th colspan="2">Số lượng</th>
            <th rowspan="2">Đơn giá</th>
            <th rowspan="2">Thành tiền</th>
        </tr>
        <tr>
            <th>Chứng từ</th>
            <th>Thực nhập</th>
        </tr>
    </thead>
    <tbody>
    	<?php $sum = 0;?>
    	<?php foreach($data_ct as $key => $ct){ ?>
        <?php $sum += $ct['thanhtien'];?>
    	<tr>
        	<td><?php echo $key + 1 ?></td>
            <td><?php echo $ct['itemname']?></td>
            <td><?php echo $ct['lothang']?></td>
            <td align="center"><?php echo $this->document->getDonViTinh($ct['madonvi'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($ct['chungtu'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($ct['thucnhap'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($ct['dongia'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($ct['thanhtien'])?></td>
        </tr>
        <?php } ?>
    </tbody>
    <tfoot>
    	<tr>
    		<td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td>Tổng cộng:</td>
            <td class="number"><?php echo $this->string->numberFormate($sum)?></td>
        </tr>
    </tfoot>
</table>

<table style="margin:15px 0">
	<tr>
    	<th width="25%">Trưởng kho</th>
        <th width="25%">Kế toán</th>
        <th width="25%">Người giao</th>
        <th width="25%">Thủ kho</th>
    </tr>
</table>
