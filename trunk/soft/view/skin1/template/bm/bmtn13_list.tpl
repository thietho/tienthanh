<h2>Phiếu yêu cầu kiểm kết quả nghiệm thu</h2>
<form id="frm_bmtn13_list">
<table>
	<thead>
    	<tr>
        	<th>Số phiếu</th>
            <th>Nhân viên lập</th>
            <th>Ngày lập</th>
            <th>Số phiếu giao hàng</th>
            <th>Số kế hoạch đạt hàng</th>
            <th>Nghiệm thu</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
    	<?php foreach($data_bttn13 as $item){ ?>
        <tr>
        	<td><?php echo $item['sophieu']?></td>
            <td><?php echo $this->document->getNhanVien($item['nhanvienlap'])?></td>
            <td><?php echo $this->date->formatMySQLDate($item['ngaylapphieu'])?></td>
            <td><?php echo $item['sophieugiaohang']?></td>
            <td><?php echo $item['sokehoachdathang']?></td>
            <td><?php echo $this->document->nghiemthu[$item['nghiemthu']]?></td>
            <td>
            	<?php if($item['nghiemthu'] == ""){ ?>
            	<input type="button" class="button" value="Chỉnh sửa">
                <?php } ?>
            </td>
        </tr>
        <?php } ?>
    </tbody>
</table>
</form>