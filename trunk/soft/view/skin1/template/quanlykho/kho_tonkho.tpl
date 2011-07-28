<div class="section">

	<div class="section-title">Tồn kho</div>
    
    <div class="section-content">
    	<?php foreach($datas as $item){ ?>
        <div>
            <label><?php echo $item['tenkho']?></label>
            <table>
                <thead>
                    <tr>
                        <th>Tem</th>
                        <th>Kho</th>
                        <th>Số lượng</th>
                        <th>Thực nhập</th>
                        <th>Bao bì</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach($item['chitiets'] as $val){ ?>
                    <tr>
                        <td><?php echo $val['id']?></td>
                        <td><?php echo $this->document->getNhom($this->document->getPhieuNhapXuat($val['maphieu'],"makho"))?></td>
                        <td class="number"><?php echo $this->string->numberFormate($val['soluong'],0)?> <?php echo $this->document->getDonViTinh($val['madonvi'])?></td>
                        <td class="number"><?php echo $this->string->numberFormate($val['thucnhap'],0)?> <?php echo $this->document->getDonViTinh($val['madonvi'])?></td>
                        <td class="number"><?php echo $this->string->numberFormate($val['baobi'],0)?> <?php echo $this->document->getDonViTinh($val['madonvi'])?></td>
                    </tr>
                    <?php } ?>
                </tbody>
            </table>
        </div>
        <?php } ?>
    </div>
</div>
        
     