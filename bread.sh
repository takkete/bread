a=`perl -e '
foreach(split / /, "0,60 62,125 197,125 324,60"){
	my($x,$w) = split /,/,$_;
	print qq#<rect x="$x" y="0" width="$w" height="650" stroke="black" fill="none"></rect>#;
}
foreach(split / /, "8:red 50:blue 334:red 376:blue"){
	my($x,$c) = split /:/,$_;
	print qq#<line x1="$x" y1="25" x2="$x" y2="620" stroke="$c" stroke-width="2"/>#;
}

$x=90;
foreach $ch (split //,"abcdefghij"){
	print qq#<text x="$x" y="20" font-size="15" text-anchor="middle">$ch</text>#;
	print qq#<text x="$x" y="638" font-size="15" text-anchor="middle">$ch</text>#;
	$x += 20;
	$x += 25 if($ch eq "e");
}

for($x=1;$x<=14;$x++){
	for($y=1;$y<=30;$y++){
		my($xx,$yy) = get_board_xxyy($x,$y);
		print qq#<rect x="$xx" y="$yy" width="9" height="9" fill="glay"></rect>#;
		if($x == 5 or $x == 14){
			$xx -=10 if($x == 5);
			$xx +=20 if($x == 14);;
			$yy +=10;
			print qq#<text x="$xx" y="$yy" font-size="13" text-anchor="middle">$y</text>#;
		}
	}
}

sub put_ic{
	my($x1,$y1, $x2,$y2) = @_;
	my($xx1,$yy1) = get_xxyy($x1,$y1);
	my($xx2,$yy2) = get_xxyy($x2,$y2);
	$xx1 +=6;
	$xx2 -=5;
	$yy1 -=5;
	$yy2 +=5;
	$w = $xx2 - $xx1;
	$h = $yy2 - $yy1;
	print qq#<rect x="$xx1" y="$yy1" width="$w" height="$h" fill="black"></rect>#;

	for($i=$y1; $i<=$y2; $i++){
		my($ix,$iy) = get_xxyy($x1,$i);
		$iy-=4;
		print qq#<rect x="$ix" y="$iy" width="7" height="10" fill="silver"></rect>#;
		my($ix,$tmp) = get_xxyy($x2,$i);
		$ix-=6;
		print qq#<rect x="$ix" y="$iy" width="7" height="10" fill="silver"></rect>#;
	}

}
sub put_wire{
	my($color,$x1,$y1, $x2,$y2) = @_;
	my($xx1,$yy1) = get_xxyy($x1,$y1);
	my($xx2,$yy2) = get_xxyy($x2,$y2);
	print qq#<circle cx="$xx1" cy="$yy1" r="3" fill="white" />#;
	print qq#<circle cx="$xx2" cy="$yy2" r="3" fill="white" />#;
	print qq#<line x1="$xx1" y1="$yy1" x2="$xx2" y2="$yy2" stroke="$color" stroke-width="8"/>#;

}
sub put_led{
	my($x1,$y1, $x2,$y2) = @_;
	my($xx1,$yy1) = get_xxyy($x1,$y1);
	my($xx2,$yy2) = get_xxyy($x2,$y2);
	my($xc,$yc) = get_center($xx1,$yy1,$xx2,$yy2);
	print qq#<circle cx="$xx1" cy="$yy1" r="3" fill="white" />#;
	print qq#<circle cx="$xx2" cy="$yy2" r="3" fill="white" />#;
	print qq#<line x1="$xx1" y1="$yy1" x2="$xx2" y2="$yy2" stroke="black" stroke-width="5"/>#;
	print qq#<line x1="$xx1" y1="$yy1" x2="$xx2" y2="$yy2" stroke="silver" stroke-width="4"/>#;
	print qq#<circle cx="$xc" cy="$yc" r="8" stroke="red" stroke-width="2" fill="pink" />#;

}

sub get_center{
	my($x1,$y1,$x2,$y2) = @_;

	my $x = $x1 + ($x2 - $x1)/2;
	my $y = $y1 + ($y2 - $y1)/2;
	return ($x,$y);
}

sub get_xxyy{
	my($x,$y) = get_board_xxyy(@_);
	return ($x+4,$y+4);
}

sub get_board_xxyy{
	my($x,$y) = @_;
	$x-=1;
	$y-=1;
	if($x < 4){
		my $w = 20;
		$xx = $x * $w + 15 + ($x >= 2)*285;
		$y = 0 if($y >= 25);
		$yy = $y * 20 + 35 + int($y /5) * 20;
	}else{
		my $w = 19;
		$xx = $x * $w + 10 + ($x >= 9)*32;
		$yy = $y * 20 + 30;
	}
	return ($xx,$yy);
}
'`


cat <<EOL > /tmp/tmp.svg
<svg width="384" height="650">
<rect x="0" y="0" width="384" height="650" fill="white"></rect>
$a
</svg>
EOL
inkscape -z -e out.png /tmp/tmp.svg -w 384 -h 600
