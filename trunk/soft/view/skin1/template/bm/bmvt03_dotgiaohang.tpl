<form id="frm_phanhoithoigiancungung">
<p>&nbsp;</p>
<input type="hidden" id="id" name="id" value="<?php echo $item['id']?>"/>
<p>
	<label>Số phiếu</label>
    <?php echo $arr_pheduyet[$item['tinhtrang']]?>
</p>
<table class="table-data">
	<thead>
        <tr>
            <th rowspan="2">STT</th>
            <th rowspan="2">Tên hàng và qui cách</th>
            <th rowspan="2">ĐVT</th>
            <th colspan="2">Tồn hiện tại</th>
            <th colspan="2">Qui dịnh</th>
            <th rowspan="2"  width="135px">Phê duyệt</th>
            <th rowspan="2">T/G yêu cầu cung ứng</th>
            <th rowspan="2">Phản hồi T/G cung ứng</th>
            <th rowspan="2">Kết quả thực hiện</th>
            <th rowspan="2">Mục đích sử dụng</th>
        </tr>
        <tr>
          <th>Vật tư</th>
          <th>Linh kiện</th>
          <th>Tồn T/thiểu</th>
          <th>Mua T/thiểu</th>
        </tr>
        
    </thead>
    <tbody>
    	<?php if(count($data_ct)){ ?>
			<?php foreach($data_ct as $key => $ct){ ?>
    	<tr>
        	<td><?php echo $key + 1 ?></td>
            <td><?php echo $ct['itemname']?></td>
            <td><?php echo $this->document->getDonViTinh($ct['madonvi'])?></td>
            <td class="number"></td>
            <td class="number"></td>
            <td class="number"><?php echo $this->string->numberFormate($ct['tontonthieu'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($ct['muatoithieu'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($ct['pheduyet'])?></td>
            
            <td align="center"><?php echo $this->date->formatMySQLDate($ct['thoigiayeucau'])?></td>
            <td align="center">
            	<?php if($ct['pheduyet']>0){ ?>
            	<input type="text" name="thoigianphanhoi[<?php echo $ct['id']?>]" value="<?php echo $this->date->formatMySQLDate($ct['thoigianphanhoi'])?>" class="text date"/>
                <?php } ?>
            </td>
            <td><?php echo $ct['ketquathuchien']?></td>
            <td><?php echo $ct['mucdichsudung']?></td>
        </tr>
        	<?php } ?>
        <?php } ?>
    </tbody>
   
</table>
<p>&nbsp;</p>
<table>
	<tr>
    	<th width="33%">Giám đốc</th>
        <th width="33%">Trưởng kho</th>
       
        <th width="33%">Thư ký</th>
    </tr>
</table>
</form>
<script language="javascript">
	numberReady();
	
</script>