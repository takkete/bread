a=`perl -e '
use Math::Trig;
@colors=("black","brown","red","orange","yellow","green","blue","purple","gray","white");
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
		print qq#<rect x="$xx" y="$yy" width="9" height="9" fill="black"></rect>#;
		if($x == 5 or $x == 14){
			$xx -=10 if($x == 5);
			$xx +=20 if($x == 14);;
			$yy +=10;
			print qq#<text x="$xx" y="$yy" font-size="13" text-anchor="middle">$y</text>#;
		}
	}
}

foreach (@ARGV){
	s/a(\d+)/5,$1/g;
	s/b(\d+)/6,$1/g;
	s/c(\d+)/7,$1/g;
	s/d(\d+)/8,$1/g;
	s/e(\d+)/9,$1/g;
	s/f(\d+)/10,$1/g;
	s/g(\d+)/11,$1/g;
	s/h(\d+)/12,$1/g;
	s/i(\d+)/13,$1/g;
	s/j(\d+)/14,$1/g;
	put_resistor(split /,/,$_) if(/R$/);
	put_wire(split /,/,$_) if(/W$/);
	put_led(split /,/,$_) if(/L$/);
	put_ic(split /,/,$_) if(/I$/);
}
put_wire("red",1,1, 5,1);
put_wire("black",2,11, 8,21);
put_resistor(12,15, 12,20, 1000);
put_resistor(6,5, 10,8, 20000);
put_led("red",6,24, 11,26);
put_led("blue",6,28, 11,28);
put_led("yellow",6,29, 11,29);
put_ic(9,26, 10,29);

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

	$arc_xx2 = $xx1+$w/2;
	$arc_yy2 = $yy1+10;
	$arc_xx1 = $arc_xx2-10;
	$arc_yy1 = $yy1;
	$arc_xx3 = $arc_xx2+10;
	$arc_yy3 = $yy1;
	print qq#<path d="M $arc_xx1 $arc_yy1 Q $arc_xx1 $arc_yy2 $arc_xx2 $arc_yy2 Q $arc_xx3 $arc_yy2 $arc_xx3 $arc_yy3" stroke="white" fill="gray"/>#;
}

sub put_wire{
	my($color,$x1,$y1, $x2,$y2) = @_;
	my($xx1,$yy1) = get_xxyy($x1,$y1);
	my($xx2,$yy2) = get_xxyy($x2,$y2);
	print qq#<circle cx="$xx1" cy="$yy1" r="3" fill="white" />#;
	print qq#<circle cx="$xx2" cy="$yy2" r="3" fill="white" />#;
	print qq#<line x1="$xx1" y1="$yy1" x2="$xx2" y2="$yy2" stroke="$color" stroke-width="8"/>#;
}

sub put_stripedwire{
	my($x1,$y1, $x2,$y2) = @_;
	my($xx1,$yy1) = get_xxyy($x1,$y1);
	my($xx2,$yy2) = get_xxyy($x2,$y2);
	my($xxc,$yyc) = get_center($xx1,$yy1,$xx2,$yy2);
	my($rr) = get_rr($xx1,$yy1,$xx2,$yy2);
	print qq#<circle cx="$xx1" cy="$yy1" r="3" fill="white" />#;
	print qq#<circle cx="$xx2" cy="$yy2" r="3" fill="white" />#;
	print qq#<line x1="$xx1" y1="$yy1" x2="$xx2" y2="$yy2" stroke="black" stroke-width="5"/>#;
	print qq#<line x1="$xx1" y1="$yy1" x2="$xx2" y2="$yy2" stroke="silver" stroke-width="4"/>#;
	return ($xxc,$yyc,$rr);
}

sub put_resistor{
	my $ohm = @_[4];
	my($xxc,$yyc,$rr) = put_stripedwire(@_);
	@resi = split //,$ohm;

	my ($xx1,$yy1) = ($xxc-20,$yyc-5);
	my ($xxb1,$yyb1,$cb1) = ($xxc-15,$yyc-5,$colors[$resi[0]]);
	my ($xxb2,$yyb2,$cb2) = ($xxc-7,$yyc-5,$colors[$resi[1]]);
	my ($xxb3,$yyb3,$cb3) = ($xxc+1,$yyc-5,$colors[$#resi]);
	my ($xxb4,$yyb4,$cb4) = ($xxc+11,$yyc-5,"gold");

	print qq#<rect x="$xx1" y="$yy1" width="40" height="10" stroke="black" fill="white" transform="rotate($rr,$xxc,$yyc)"></rect>#;
	print qq#<rect x="$xxb1" y="$yyb1" width="4" height="10" fill="$cb1" transform="rotate($rr,$xxc,$yyc)"></rect>#;
	print qq#<rect x="$xxb2" y="$yyb2" width="4" height="10" fill="$cb2" transform="rotate($rr,$xxc,$yyc)"></rect>#;
	print qq#<rect x="$xxb3" y="$yyb3" width="4" height="10" fill="$cb3" transform="rotate($rr,$xxc,$yyc)"></rect>#;
	print qq#<rect x="$xxb4" y="$yyb4" width="4" height="10" fill="$cb4" transform="rotate($rr,$xxc,$yyc)"></rect>#;
}

sub put_led{
	my $color = shift;
	my($xxc,$yyc) = put_stripedwire(@_);
	print qq#<circle cx="$xxc" cy="$yyc" r="9" fill="$color" />#;
}

sub get_center{
	my($xx1,$yy1,$xx2,$yy2) = @_;
	my $xxc = $xx1 + ($xx2 - $xx1)/2;
	my $yyc = $yy1 + ($yy2 - $yy1)/2;
	return ($xxc,$yyc);
}

sub get_rr{
	my($xx1,$yy1,$xx2,$yy2) = @_;
	my($ww, $hh) = ($xx2-$xx1, $yy2-$yy1);
	my $rr = rad2deg atan2($ww,$hh);
	return 90 - $rr;
}

sub get_xxyy{
	my($xx,$yy) = get_board_xxyy(@_);
	return ($xx+4,$yy+4);
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
' $@`

cat <<EOL > /tmp/tmp.svg
<svg width="384" height="650">
<rect x="0" y="0" width="384" height="650" fill="white"></rect>
$a
</svg>
EOL
inkscape -z -e out.png /tmp/tmp.svg -w 384 -h 600
