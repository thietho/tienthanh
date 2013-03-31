<table>
	<thead>
    	<tr>
        	<th rowspan="2">STT</th>
            <th rowspan="2">Mã SP</th>
            <th rowspan="2">Tên SP</th>
            <th colspan="4">2012</th>
            <th colspan="4">2013</th>
        </tr>
    	<tr>
        	<th>Quý 1</th>
            <th>Quý 2</th>
            <th>Quý 3</th>
            <th>Quý 4</th>
            <th>Quý 1</th>
            <th>Quý 2</th>
            <th>Quý 3</th>
            <th>Quý 4</th>
        </tr>
    </thead>
    <tbody>
    	<?php foreach($nhomsanpham as $nhom){ ?>
       	<tr>
        	<td colspan="11"><strong><?php echo $nhom['tennhom']?></strong></td>
        </tr>
        <?php foreach($khsp as $item){ ?>
        <?php if($item['manhom'] == $nhom['manhom']){ ?>
        
    	<tr>
        	<td></td>
            <td><?php echo $item['masanpham']?></td>
            <td><?php echo $item['tensanpham']?></td>
        </tr>
        <?php } ?>
        <?php } ?>
        <?php } ?>
    	
    </tbody>
</table>
