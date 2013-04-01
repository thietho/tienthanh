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
        <?php $count=0?>
    	<?php foreach($nhomsanpham as $nhom){ ?>
       	<tr>
        	<td colspan="19"><strong><?php echo $nhom['tennhom']?></strong></td>
        </tr>
        <?php foreach($khsp as $item){ ?>
        <?php if($item['manhom'] == $nhom['manhom']){ ?>
        
    	<tr>
        	<td><center><?php echo $index++?></center></td>
            <td><?php echo $item['masanpham']?></td>
            <td><?php echo $item['tensanpham']?></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <?php foreach($data_kehoachquy as $quy){ ?>
            <td>
            	<form id="frm_kehoachsanpham_<?php echo $count++; ?>" class="frmkehoachsanpham">
                    <input type="text" class="text short number soluong" id="soluong_<?php echo $quy[id]?>_<?php echo $item['sanphamid']?>" name="soluong"/>
                    <input type="hidden" id="dongia" name="dongia" value="<?php echo $item['dongia']?>"/>
                    <input type="hidden" name="id" value="<?php echo $item['id']?>"/>
                    <input type="hidden" name="kehoachid" value="<?php echo $quy['id']?>"/>
                    <input type="hidden" name="sanphamid" value="<?php echo $item['sanphamid']?>"/>
                    <input type="hidden" name="masanpham" value="<?php echo $item['masanpham']?>"/>
                    <input type="hidden" name="manhom" value="<?php echo $item['tensanpham']?>"/>
                    <input type="hidden" name="tensanpham" value="<?php echo $item['tensanpham']?>"/>
                    <input type="hidden" name="soluongtonhientai" value="<?php echo $item['soluongtonhientai']?>"/>
                    <input type="hidden" name="sosanphamtrenlot" value="<?php echo $item['sosanphamtrenlot']?>"/>
                    
                </form>
            </td>
            <td>
            	<div id="thanhtien_<?php echo $quy[id]?>"></div>
            </td>
            <?php } ?>
        </tr>
        <?php } ?>
        <?php } ?>
        <?php } ?>
    	
    </tbody>
</table>
<script language="javascript">
var count = <?php echo $count?>
</script>
