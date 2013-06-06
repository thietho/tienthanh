<table class="table-data">
	<tr>
    	<td width="118"><img src="<?php echo DIR_IMAGE?>logotienthanh.png"></td>
      	<td align="center">
        	<h2>Phiếu yêu cầu kiểm kết quả nghiệm thu</h2>
	        <p>Ngày <?php echo $this->date->getDay($item['ngaylapphieu'])?> tháng <?php echo $this->date->getMonth($item['ngaylapphieu'])?> năm <?php echo $this->date->getYear($item['ngaylapphieu'])?></p>
      	</td>
      	<td width="180px">
            <p>Mã hiệu: BM-TN-13</p>
            <p>Lần phát hành: 02</p>
            <p>Lần sửa đổi: 01</p>
            <p>Ngày phát hành: 19/02/09</p>
            <p>Số: <?php echo $item['sophieu']?></p>
      	</td>
    </tr>
</table>
<table style="margin:10px 0 0;">
	<tr>
   	  <td>Phòng kiểm nghiệm đo lường chất lượng đồng ý:</td>
      <td>Nghiệm thu: <input type="checkbox"></td>
      <td>Không đồng ý: <input type="checkbox"></td>
    </tr>
</table>
<table style="margin:10px 0 0;">
	<tr>
   	  <td>Lô hàng theo phiếu giao hàng số: <?php echo $item['sophieugiaohang']?></td>
      <td>Ngày: <?php echo $this->date->formatMySQLDate($item['ngayphieugiaohang'])?></td>
      <td>Tên vật tư: </td>
    </tr>
</table>
<table style="margin:10px 0 0;">
	<tr>
   	  <td>Công ty: <?php echo $item['tennhacungung']?></td>
      <td>Theo kế hoạch đặt hàng số: <?php echo $item['sokehoachdathang']?></td>
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
    	<?php foreach($data_chitiet as $key => $ct){ ?>
    	<tr>
        	<td><?php echo $key + 1 ?></td>
            <td><?php echo $ct['tennguyenlieu']?></td>
            <td><?php echo $ct['lotnguyenlieu']?></td>
            <td align="center"><?php echo $this->document->getDonViTinh($ct['donvi'])?></td>
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
            <td class="number"><?php echo $this->string->numberFormate($item['tongsotien'])?></td>
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
<script language="javascript">
window.print();
</script>