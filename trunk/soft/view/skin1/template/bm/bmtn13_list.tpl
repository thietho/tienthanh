<h2>Phiếu yêu cầu kiểm kết quả nghiệm thu</h2>
<form id="frm_bmtn13_list">
<table>
	<thead>
    	<tr>
        	<th>Số phiếu</th>
            <th>Nhân viên lập</th>
            <th>Ngày lập</th>
            <th>Số phiếu giao hàng</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
    	<?php foreach($data_bttn13 as $item){ ?>
        <tr>
        	<td><?php echo $item['sophieu']?></td>
            <td><?php echo $item['nhanvienlap']?></td>
            <td><?php echo $item['ngaylapphieu']?></td>
        </tr>
        <?php } ?>
    </tbody>
</table>
</form>