				<?php echo $pager?>
                <table class="data-table" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="tr-head">
                    	<?php if($dialog!=true){ ?>
                        <th width="1%">
                        	<?php if($dialog!=true){ ?>
                        	<input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);">
                            <?php } ?>
                        </th>
                        <?php } ?>
                        <th>STT</th>
                        <th>Mã sản phẩm</th>
                        <th>Tên sản phẩm</th>
                        <th>Nhóm</th>
                        <th>Loại</th>
                        <th>Kho</th>
                        <th>Đơn vị tính</th>
                        <?php if($dialog!=true){ ?>
                        <?php if($this->user->getUserTypeId()=='admin'){ ?>
                        <th>Giá cố định</th>
                        <th>Đơn giá bán theo cái</th>
                        <th>Đơn giá bán theo hộp</th>
                        <th>Đơn giá bán theo thùng</th>
                        <th>Đơn giá bán theo lot</th>
                        <?php } ?>
                        <th>Số lượng tồn</th>
                        <th>Đóng gói</th>
                        <th>Số sản phẩm /Lot</th>
                        <th>Khu vực</th>
                        <th>Phân cấp</th>
                        <?php } ?>
                        <th>Hiện hành</th>
                        <th>Ghi chú</th>
                        <th>Hình</th>
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
                    <tr class="item" id="<?php echo $item['id']?>" masanpham="<?php echo $item['masanpham']?>" tensanpham="<?php echo $item['tensanpham']?>">
                    	<?php if($dialog!=true){ ?>
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo $item['id']?>]" value="<?php echo $item['id']?>" ></td>
                        <?php } ?>
                        <td><?php echo $key+1 ?></td>
                        <td><?php echo $item['masanpham']?></td>
                        <td><?php echo $item['tensanpham']?></td>
                        <td><?php echo $item['tennhom']?></td>
                        <td><?php echo $item['tenloai']?></td>
                        <td><?php echo $item['tenkho']?></td>
                        <td><?php echo $item['madonvi']?></td>
                        <?php if($dialog!=true){ ?>
                        <?php if($this->user->getUserTypeId()=='admin'){ ?>
                        <td class="number"><?php echo $this->string->numberFormate($item['giacodinh'])?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['dongiabancai'])?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['dongiabanhop'])?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['dongiabanthung'])?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['dongiabanlot'])?></td>
                        <?php } ?>
                		<td class="number"><?php echo $this->string->numberFormate($item['soluongton'])?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['donggoi'])?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['sosanphamtrenlot'])?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['khuvuc'])?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['phancap'])?></td>
                        <?php } ?>
                        <td><?php echo $this->document->hienhanh[$item['hienhanh']]?></td>
                        <td><?php echo $item['ghichu']?></td>
                        <td><img src="<?php echo $item['imagethumbnail']?>" /></td>
                        <?php if($dialog!=true){ ?>
                        <td class="link-control">
                            <?php if($this->user->checkPermission("quanlykho/sanpham/update")==true){ ?>
                            <input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="window.location='<?php echo $item['link_edit']?>'"/>
                            <?php } ?>
                            <?php if($this->user->checkPermission("quanlykho/sanpham/dinhluong")==true){ ?>
                            <input type="button" class="button" name="btnDinhLuong" value="<?php echo $item['text_dinhluong']?>" onclick="window.location='<?php echo $item['link_dinhluong']?>'"/>
                            <?php } ?>
                            <?php if($this->user->checkPermission("quanlykho/sanpham/congdoan")==true){ ?>
                            <input type="button" class="button" name="btnCongDoan" value="<?php echo $item['text_congdoan']?>" onclick="window.location='<?php echo $item['link_congdoan']?>'"/>
                            <?php } ?>
                            <?php if($this->user->checkPermission("quanlykho/sanpham/lichsu")==true){ ?>
                            <input type="button" class="button" name="btnLichSu" value="<?php echo $item['text_lichsu']?>" onclick="viewSanPham('<?php echo $item['masanpham']?>')"/>
                            <?php } ?>
                            <?php if($this->user->checkPermission("quanlykho/sanpham/catdatchiphi")==true){ ?>
                            <input type="button" class="button" name="btnCaiDatChiPhi" value="<?php echo $item['text_caidatchiphi']?>" onclick="window.location='<?php echo $item['link_caidatchiphi']?>'"/>
                            <?php } ?>
                            <?php if($this->user->checkPermission("quanlykho/sanpham/tinhtiencongtonghop")==true){ ?>
                            <input type="button" class="button" name="btnTinhTienCongTonghop" value="<?php echo $item['text_tinhtiencongtonghop']?>" onclick="window.location='<?php echo $item['link_tinhtiencongtonghop']?>'"/>
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
	intSelectSanPham()
</script>
<?php } ?>