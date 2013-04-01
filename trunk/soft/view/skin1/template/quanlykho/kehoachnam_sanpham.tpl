<table class="data-table">
	<thead>
    	<tr>
        	<th rowspan="3">STT</th>
            <th rowspan="3">Mã SP</th>
            <th rowspan="3">Tên SP</th>
            <th colspan="8"><?php echo $kehoach['nam'] -1 ?></th>
            <th colspan="8"><?php echo $kehoach['nam']?></th>
        </tr>
    	<tr>
        	<th colspan="2">Quý 1</th>
            <th colspan="2">Quý 2</th>
            <th colspan="2">Quý 3</th>
            <th colspan="2">Quý 4</th>
            <th colspan="2">Quý 1</th>
            <th colspan="2">Quý 2</th>
            <th colspan="2">Quý 3</th>
            <th colspan="2">Quý 4</th>
        </tr>
        <tr>
        	<th>Số lượng</th>
        	<th>Thành tiền</th>
            <th>Số lượng</th>
            <th>Thành tiền</th>
            <th>Số lượng</th>
            <th>Thành tiền</th>
            <th>Số luộng</th>
            <th>Thành tiền</th>
            <th>Số lượng</th>
            <th>Thành tiền</th>
            <th>Số lượng</th>
            <th>Thành tiền</th>
            <th>Số lượng</th>
            <th>Thành tiền</th>
            <th>Số lượng</th>
            <th>Thành tiền</th>
        </tr>
    </thead>
    <tbody>
    	<?php $index = 1;?>
        <?php $count = 0;?>
    	<?php foreach($nhomsanpham as $nhom){ ?>
       	<tr>
        	<td colspan="19"><strong><?php echo $nhom['tennhom']?></strong></td>
        </tr>
        <?php foreach($data_sanpham as $item){ ?>
        <?php if($item['manhom'] == $nhom['manhom']){ ?>
        
    	<tr id="row_khoachnam_sanpham<?php echo $count?>">
        	
        	<td><center><?php echo $index++?></center></td>
            <td><?php echo $item['masanpham']?></td>
            <td>
            	<?php echo $item['tensanpham']?>
                
                <input type="hidden" id="sanphamid" value="<?php echo $item['id']?>" />
                <input type="hidden" id="masanpham" value="<?php echo $item['masanpham']?>" />
                <input type="hidden" id="tensanpham" value="<?php echo $item['tensanpham']?>" />
                <input type="hidden" id="manhom" value="<?php echo $item['manhom']?>" />
                <input type="hidden" id="giacodinh" value="<?php echo $item['giacodinh']?>" />
                <input type="hidden" id="sosanphamtrenlot" value="<?php echo $item['sosanphamtrenlot']?>" />
            </td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <?php for($i=1;$i<=4;$i++){ ?>
            <td>
            	<input type="text" class="text short number soluong" id="qui<?php echo $i?>" name="qui<?php echo $i?>" value="<?php echo $item['qui'.$i]?>" ref="<?php echo $count?>"/>
                
             </td>
            <td></td>
 			<?php } ?>           
            <?php $count++?>
        </tr>
        
        <?php } ?>
        <?php } ?>
        <?php } ?>
    	
    </tbody>
</table>
<script language="javascript">
var count = <?php echo $count?>;
$('.soluong').keyup(function(e) {
    var pos = $(this).attr('ref');
	
	saveitem(pos);
});

</script>
