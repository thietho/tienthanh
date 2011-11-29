<table>
	<thead>
    	<tr>
            <th>Mã SP</th>
            <th>Tên SP</th>
            <th>SL theo kê hoạch kỳ trước</th>
            <th>Thành tiền kỳ trước</th>
            <th>Kết quả thực hiện kỳ trước</th>
            <th>Kết quả kinh doanh kỳ trước</th>
            <th>Tồn thực tại</th>
            <th>SL qui định SX 1 lot</th>
            <th>Tổng số cái SX</th>
            <th>Qui đổi số LOT SX</th>
            <th>Thành tiền</th>
            <th>Phê duyệt</th>
            <th>Phụ chú</th>
            <th>Tổng SL cùng kỳ năm qua</th>
            <th>Tổng SL cùng kỳ năm trước</th>
        </tr>
    </thead>
    <tbody>
    	<?php foreach($khsp as $item){ ?>
    	<tr>
        	<td><?php echo $item['masanpham']?></td>
            <td><?php echo $item['tensanpham']?></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td class="number"><?php echo $item['soluongtonhientai']?></td>
            <td class="number"><?php echo $item['sosanphamtrenlot']?></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <?php } ?>
    </tbody>
</table>