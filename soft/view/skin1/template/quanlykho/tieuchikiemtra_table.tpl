				<?php echo $pager?>
                <table class="data-table" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="tr-head">
                    	<?php if($dialog!=true){ ?>
                        <th width="1%">
                        	
                        	<input id="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);">
                           
                        </th>
                        <?php } ?>
                        <th>STT</th>
                        <th>Loại</th>
                        <th>
                        	Tên vật tư
                        </th>
                        
                        <?php if($dialog!=true){ ?>
                        <th>Control</th>     
                        <?php } ?>
                    </tr>
                </thead>
                <tbody>
        
        
        <?php
            foreach($datas as $key => $item)
            {
        ?>
                    <tr class="item" id="<?php echo $item['id']?>" itemid="<?php echo $item['itemid']?>" itemtype="<?php echo $item['itemtype']?>" itemname="<?php echo $item['itemname']?>">
                    	<?php if($dialog!=true){ ?>
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo $item['id']?>]" value="<?php echo $item['id']?>" ></td>
                        <?php } ?>
                        <td><?php echo $key+1 ?></td>
                        <td><?php echo $item['itemtype']?></td>
                        <td><?php echo $item['itemname']?></td>
                        <?php if($dialog!=true){ ?>
                        <td><?php echo $item['tenloai']?></td>
                        <td><?php echo $item['tenkho']?></td>
                        
                		<td class="number">
                        	<?php if($item['soluongton'] >0){?>
                            <a onclick="viewTonKho(<?php echo $item['id']?>)"><?php echo $this->string->numberFormate($item['soluongton'],0)?></a>
                            <?php }else{?>
                        	<?php echo $this->string->numberFormate($item['soluongton'],0)?>
                            <?php } ?>
                        </td>
                        <td class="number"><?php echo $this->string->numberFormate($item['tontoithieu'],0)?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['tontoida'],0)?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['soluongmoilandathang'],0)?></td>
                        <?php } ?>
                        <td><?php echo $this->document->getDonViTinh($item['madonvi'])?></td>
                        
                        <td><?php echo $item['mucdichsudung']?></td>
                        <td><?php echo $item['ghichu']?></td>
                        <td><img src="<?php echo $item['imagethumbnail']?>" /></td>
                        <?php if($dialog!=true){ ?>
                        <td class="link-control">
                            <?php if($this->user->checkPermission("quanlykho/nguyenlieu/update")==true){ ?>
                            <input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="window.location='<?php echo $item['link_edit']?>#page='+control.getParam('page')"/>
                            <?php } ?>
                           
                            
                        </td>
                        <?php } ?>
                    </tr>
        <?php
            }
        ?>
                        
                                                    
                </tbody>
                </table>
                <?php echo $pager?>

<?php if($dialog){ ?>
<script language="javascript">
	intSelectNguyenLieu()
</script>
<?php } ?>