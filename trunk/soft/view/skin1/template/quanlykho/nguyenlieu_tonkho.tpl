<div class="section">
    <div class="section-content">
        <div><label><?php echo $item['tennguyenlieu']?> tồn:</label> <?php echo $this->string->numberFormate($item['soluongton'],0)?>
        <?php echo $this->document->getDonViTinh($item['madonvi'])?>
        <table>
            <thead>
                <tr>
                    <th>Số phiếu</th>
                    <th>Ngày nhập</th>
                    <th>Lot nguyên liệu</th>
                    <th>Kho</th>
                    <th>Số lượng</th>
                    <th>Thực nhập</th>
                    
                </tr>
            </thead>
            <tbody>
            <?php foreach($datact as $val){ ?>
                <tr>
                    <td><?php echo $this->document->getPhieuNhapVatTuHangHoa($val['phieunhapvattuhanghoaid'])?></td>
                    <td><?php echo $val['ngaynhap']?></td>
                    <td><?php echo $val['lotnguyenlieu']?></td>
                    <td><?php echo $this->document->getNhom($val['makho'])?></td>
                    <td class="number">
                        <?php echo $this->string->numberFormate($val['chungtu'])?>
                        <?php echo $this->document->getDonViTinh($val['donvi'])?>
                    </td>
                    <td class="number">
                        <?php echo $this->string->numberFormate($val['thucnhap'])?>
                        <?php echo $this->document->getDonViTinh($val['donvi'])?>
                    </td>
                    
                </tr>
                <?php } ?>
            </tbody>
            
        </table>
    </div>
		
</div>

