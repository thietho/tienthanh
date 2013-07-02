<table class="table-data">
	<tr>
    	<td width="80px"><img src="<?php echo DIR_IMAGE?>logotienthanh.png" width="80px"></td>
      	<td align="center">
        	<h2>Phiếu yêu cầu kiểm kết quả nghiệm thu</h2>
	        
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
   	  <td width="40%">Phòng kiểm nghiệm đo lường chất lượng đồng ý:</td>
      <td width="30%">Nghiệm thu: <input type="checkbox" <?php if($item['nghiemthu'] == 'nghieuthu') echo "checked"?>></td>
      <td width="30%">Không đồng ý: <input type="checkbox" <?php if($item['nghiemthu'] == 'khongdongy') echo "checked"?>></td>
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
            <th>STT</th>
            <th>Tên hàng - qui cách</th>
            <th>T/Lượng</th>
            <th>S.Lượng</th>
            <th>Chất lượng</th>
            <th>Lot hàng hóa</th>
        </tr>
        
    </thead>
    <tbody>
    	<?php if(count($data_ct)){ ?>
			<?php foreach($data_ct as $key => $ct){ ?>
    	<tr>
        	<td><?php echo $key + 1 ?></td>
            <td><?php echo $ct['itemname']?></td>
            <td class="number"><?php echo $this->string->numberFormate($ct['trongluong'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($ct['soluong'])?></td>
            <td class="number"><?php echo $ct['chatluong']?></td>
            <td class="number"><?php echo $ct['lothang']?></td>
        </tr>
        	<?php } ?>
        <?php } ?>
    </tbody>
   
</table>
<table>
	<tr>
    	<td width="33%" align="center">Toàn bộ: <input type="checkbox"  <?php if($item['tinhtrang'] == 'toanbo') echo "checked"?>></td>
        <td width="33%" align="center">Một phần: <input type="checkbox" <?php if($item['tinhtrang'] == 'motphan') echo "checked"?>></td>
       
        <th width="33%"></th>
    </tr>
</table>
<table>
	<tr>
    	<th width="33%">Nhân viên kiểm nghiệm</th>
        <th width="33%"></th>
       
        <th width="33%">Ngày <?php echo $this->date->getDay($item['ngaylapphieu'])?> tháng <?php echo $this->date->getMonth($item['ngaylapphieu'])?> năm <?php echo $this->date->getYear($item['ngaylapphieu'])?></th>
    </tr>
</table>
<div style="margin-top:80px;">
	<p>Các điều kiện cần lưu ý khi kiểm nghiệm:</p>
    <p>Điều kiện: Phế liệu - hao hụt - màu sắc - kích cở hạt - khấu trừ bao bì - khuyến mãi</p>
    <p>Độ cứng, dẻo - chiều dài - độ bóng sáng  - khó tháo, tuốt - tỷ lệ lấy mẩu kiềm - tiêu chuẩn ...</p>
</div>
