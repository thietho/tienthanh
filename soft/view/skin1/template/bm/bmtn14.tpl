<table class="table-data">
	<tr>
    	<td width="80px"><img src="<?php echo DIR_IMAGE?>logotienthanh.png" width="80px"></td>
      	<td align="center">
        	<h2>Phiếu yêu cầu kiểm kết quả nghiệm thu</h2>
	        (Có giá trị lưu hành nội bộ)
      	</td>
      	<td width="180px">
            <p>Mã hiệu: BM-TN-14</p>
            <p>Lần phát hành: 01</p>
            <p>Lần sửa đổi: 00</p>
            <p>Ngày phát hành: </p>
            <p>Số: <?php echo $item['sophieu']?></p>
      	</td>
    </tr>
</table>
<center>
	<strong>PHÒNG: KIỂM NGHIỆM</strong>
</center>
<table style="margin:10px 0 0;">
	<tr>
   	  <td width="50%">TÊN MẪU: <strong><?php echo $item['itemname']?></strong></td>
      <td width="50%"><strong>KÝ HIỆU: <?php echo $item['kyhieu']?></strong></td>
    </tr>
    <tr>
    	<td colspan="2">TÌNH TRẠNG MẪU: <?php echo $item['tinhtrangmau']?></td>
    </tr>
    <tr>
    	<td colspan="2">ĐIỀU KIỆN THỬ NGHIỆM: <?php echo $item['dkthunghiem']?></td>
    </tr>
    <tr>
    	<td colspan="2">MÔI TRƯỜNG THỬ NGHIỆM: <?php echo $item['moitruongthunghiem']?></td>
    </tr>
    <tr>
    	<td colspan="2">NGÀY YÊU CẦU RA KẾT QUẢ CHÉP TAY: <?php echo $item['ngayycrakqcheptay']?></td>
    </tr>
    <tr>
    	<td colspan="2">NGÀY YÊU CẦU GIAO KẾT QUẢ CHÉP TAY: <?php echo $item['ngayycgiaokqcheptay']?></td>
    </tr>
</table>
<center><strong>KẾT QUẢ THỬ NGHIỆM</strong></center>

<table class="table-data">
	<thead>
        <tr>
            <th>STT</th>
            <th>CHỈ TIÊU KIỂM TRA</th>
            <th>ĐVT</th>
            <th>KẾT QUẢ</th>
            <th>MỨC<br>CHẤT LƯỢNG</th>
        </tr>
        
    </thead>
    <tbody>
    	<?php if(count($data_ct)){ ?>
			<?php foreach($data_ct as $key => $ct){ ?>
    	<tr>
        	<td><?php echo $key + 1 ?></td>
            <td><?php echo $ct['tieuchikiemtra']?></td>
            <td><?php echo $ct['madonvi']?></td>
            <td><?php echo $ct['ketqua']?></td>
            <td><?php echo $ct['mucchatluong']?></td>
        </tr>
        	<?php } ?>
        <?php } ?>
    </tbody>
   
</table>
<p>ĐÁNH GIÁ KẾT QUẢ THỬ NGHIỆM</p>
<?php echo $ct['danhgiakq']?>
<table>
	<tr>
    	<th width="33%">GIÁM ĐỐC</th>
        <th width="33%">PT.KỸ THUẬT</th>
       
        <th width="33%">
        	NGƯỜI THỰC HIỆN
        	
        </th>
    </tr>
    <tr>
    	<td></td>
        <td></td>
        <td align="center">Ngày: <?php echo $this->date->formatMySQLDate($item['ngaythuchien'])?></td>
    </tr>
    <tr>
    	<td></td>
        <td></td>
        <td align="center"><div style="margin-top:70px"><?php echo $this->document->getNhanVien($item['nhanvienthuchien'])?></div></td>
    </tr>
    
</table>

<script language="javascript">
window.print();
</script>