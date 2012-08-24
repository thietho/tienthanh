<table>
	<thead>
        <tr>
        	<th>STT</th>
            <th>Mã nguyên liệu</th>
            <th>Tên nguyên liệu</th>
            <th>Tồn đầu kỳ</th>
            <th>Nhập trong kỳ</th>
            <th>Xuất trong kỳ</th>
            <th>Tồn cuối kỳ</th>
        </tr>
    </thead>
    <tbody>
    	<?php foreach($data_nguyenlieu as $key => $item){ ?>
        <tr>
        	<td><?php echo $key+1 ?></td>
            <td><?php echo $item['manguyenlieu']?></td>
            <td><?php echo $item['tennguyenlieu']?></td>
            <td class="number">0</td>
            <td class="number">0</td>
            <td class="number">0</td>
            <td class="number">0</td>
            
        </tr>
        <?php } ?>
    </tbody>
</table>