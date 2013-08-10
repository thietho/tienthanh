				<table class="data-table" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="tr-head">
                    	
                        <th>STT</th>
                        <th>Mã số</th>
                        <th>
                        	Tên
                        </th>
                        
                        <th>Đơn vị tính</th>
                        <th>Hình</th>
                        
                    </tr>
                </thead>
                <tbody>
        			<tr>
                    	<td colspan="5"><strong>Nguyên liệu</strong></td>
                    </tr>
        
        <?php
            foreach($data_nguyenlieu as $key => $item)
            {
        ?>
                    <tr class="item" id="<?php echo $item['id']?>" manguyenlieu="<?php echo $item['manguyenlieu']?>" tennguyenlieu="<?php echo $item['tennguyenlieu']?>" madonvi="<?php echo $item['madonvi']?>" tendonvi="<?php echo $this->document->getDonViTinh($item['madonvi'])?>">
                    	
                        <td><?php echo $key+1 ?></td>
                        <td><?php echo $item['manguyenlieu']?></td>
                        <td><?php echo $item['tennguyenlieu']?></td>
                        <td><?php echo $this->document->getDonViTinh($item['madonvi'])?></td>
                        <td><img src="<?php echo $item['imagethumbnail']?>" /></td>
                        
                    </tr>
        <?php
            }
        ?>
                        
                                                    
                </tbody>
                </table>

<script language="javascript">
	intSelectDuoiTonToiThieu()
</script>