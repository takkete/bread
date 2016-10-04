a=`perl -e '

use Math::Trig;
@colors=("black","brown","red","orange","yellow","green","blue","purple","gray","white");

$xx_offset=400;
$yy_offset=0;
$ww=384+$xx_offset;
$hh=650+$yy_offset;

my ($xx,$yy) = get_board_xxyy(0,0);
my ($box1_xx1,$box1_yy1) = ($xx+5,$yy-15);
my ($box2_xx1) = $box1_xx1 + 62;
my ($box3_xx1) = $box1_xx1 + 197;
my ($box4_xx1) = $box1_xx1 + 324;
my ($red1_xx1) = $box1_xx1 + 8;
my ($red2_xx1) = $box1_xx1 + 334;
my ($blue1_xx1) = $box1_xx1 + 50;
my ($blue2_xx1) = $box1_xx1 + 376;
my ($a_xx,$a_yy1,$a_yy2) = ($box1_xx1 + 90, $box1_yy1+20, $box1_yy1+638);
my ($b_xx,$b_yy1,$b_yy2) = ($box1_xx1 +110, $box1_yy1+20, $box1_yy1+638);
my ($c_xx,$c_yy1,$c_yy2) = ($box1_xx1 +130, $box1_yy1+20, $box1_yy1+638);
my ($d_xx,$d_yy1,$d_yy2) = ($box1_xx1 +150, $box1_yy1+20, $box1_yy1+638);
my ($e_xx,$e_yy1,$e_yy2) = ($box1_xx1 +170, $box1_yy1+20, $box1_yy1+638);
my ($f_xx,$f_yy1,$f_yy2) = ($box1_xx1 +215, $box1_yy1+20, $box1_yy1+638);
my ($g_xx,$g_yy1,$g_yy2) = ($box1_xx1 +235, $box1_yy1+20, $box1_yy1+638);
my ($h_xx,$h_yy1,$h_yy2) = ($box1_xx1 +255, $box1_yy1+20, $box1_yy1+638);
my ($i_xx,$i_yy1,$i_yy2) = ($box1_xx1 +275, $box1_yy1+20, $box1_yy1+638);
my ($j_xx,$j_yy1,$j_yy2) = ($box1_xx1 +295, $box1_yy1+20, $box1_yy1+638);

print qq#<svg width="$ww" height="$hh">#;
print qq#<rect x="0" y="0" width="$ww" height="$hh" fill="white"></rect>#;

print qq#<rect x="$box1_xx1" y="$yy1" width="60" height="650" stroke="black" fill="none"></rect>#;
print qq#<rect x="$box2_xx1" y="$yy1" width="125" height="650" stroke="black" fill="none"></rect>#;
print qq#<rect x="$box3_xx1" y="$yy1" width="125" height="650" stroke="black" fill="none"></rect>#;
print qq#<rect x="$box4_xx1" y="$yy1" width="60" height="650" stroke="black" fill="none"></rect>#;

print qq#<line x1="$red1_xx1" y1="25" x2="$red1_xx1" y2="620" stroke="red" stroke-width="2"/>#;
print qq#<line x1="$red2_xx1" y1="25" x2="$red2_xx1" y2="620" stroke="red" stroke-width="2"/>#;
print qq#<line x1="$blue1_xx1" y1="25" x2="$blue1_xx1" y2="620" stroke="blue" stroke-width="2"/>#;
print qq#<line x1="$blue2_xx1" y1="25" x2="$blue2_xx1" y2="620" stroke="blue" stroke-width="2"/>#;

print qq#<text x="$a_xx" y="$a_yy1" font-size="15" text-anchor="middle">a</text>#;
print qq#<text x="$b_xx" y="$b_yy1" font-size="15" text-anchor="middle">b</text>#;
print qq#<text x="$c_xx" y="$c_yy1" font-size="15" text-anchor="middle">c</text>#;
print qq#<text x="$d_xx" y="$d_yy1" font-size="15" text-anchor="middle">d</text>#;
print qq#<text x="$e_xx" y="$e_yy1" font-size="15" text-anchor="middle">e</text>#;
print qq#<text x="$f_xx" y="$f_yy1" font-size="15" text-anchor="middle">f</text>#;
print qq#<text x="$g_xx" y="$g_yy1" font-size="15" text-anchor="middle">g</text>#;
print qq#<text x="$h_xx" y="$h_yy1" font-size="15" text-anchor="middle">h</text>#;
print qq#<text x="$i_xx" y="$i_yy1" font-size="15" text-anchor="middle">i</text>#;
print qq#<text x="$j_xx" y="$j_yy1" font-size="15" text-anchor="middle">j</text>#;
print qq#<text x="$a_xx" y="$a_yy2" font-size="15" text-anchor="middle">a</text>#;
print qq#<text x="$b_xx" y="$b_yy2" font-size="15" text-anchor="middle">b</text>#;
print qq#<text x="$c_xx" y="$c_yy2" font-size="15" text-anchor="middle">c</text>#;
print qq#<text x="$d_xx" y="$d_yy2" font-size="15" text-anchor="middle">d</text>#;
print qq#<text x="$e_xx" y="$e_yy2" font-size="15" text-anchor="middle">e</text>#;
print qq#<text x="$f_xx" y="$f_yy2" font-size="15" text-anchor="middle">f</text>#;
print qq#<text x="$g_xx" y="$g_yy2" font-size="15" text-anchor="middle">g</text>#;
print qq#<text x="$h_xx" y="$h_yy2" font-size="15" text-anchor="middle">h</text>#;
print qq#<text x="$i_xx" y="$i_yy2" font-size="15" text-anchor="middle">i</text>#;
print qq#<text x="$j_xx" y="$j_yy2" font-size="15" text-anchor="middle">j</text>#;

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

foreach $arg (@ARGV){
	foreach (split /\n/,$arg){
	next if /^#/;
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
	put_resistor(split /,/,$_) if(/^RESISTOR\b/);
	put_wire(split /,/,$_) if(/^WIRE\b/);
	put_led(split /,/,$_) if(/^LED\b/);
	put_ic(split /,/,$_) if(/^IC\b/);
	put_pinheader(split /,/,$_) if(/^PIN\b/);
	put_pinlabel(split /,/,$_) if(/^LABEL\b/);
	put_pinwire(split /,/,$_) if(/^PINWIRE\b/);
	}
}

print qq#</svg>#;

sub put_pinwire{
	shift;
	my($color,$x1,$y1, $x2,$y2) = @_;
	my($xx1,$yy1) = get_xxyy($x1,$y1);
	my($xx2,$yy2) = get_xxyy($x2,$y2);
	print qq#<circle cx="$xx1" cy="$yy1" r="4" fill="white" />#;
	print qq#<circle cx="$xx2" cy="$yy2" r="4" fill="white" />#;
	print qq#<line x1="$xx1" y1="$yy1" x2="$xx2" y2="$yy2" stroke="$color" stroke-width="12" stroke-opacity="0.5" />#;
}
sub put_pinlabel{
	shift;
	my($color,$x,$y,$text) = @_;
	my($xx,$yy) = get_xxyy($x,$y);
	my $l_xx;
	my $l_yy = $yy + 5;
	if($x == 21){
		$l_xx = $xx - 20;
		print qq#<text x="$l_xx" y="$l_yy" font-size="15" text-anchor="end" stroke="$color" fill="none" >$text</text>#;
	}else{
		$l_xx = $xx + 20;
		print qq#<text x="$l_xx" y="$l_yy" font-size="15" text-anchor="start" stroke="$color" fill="none" >$text</text>#;
	}
}

sub put_pinheader{
	shift;
	my($x1,$y1,$x2,$y2) = @_;
	my($xx1,$yy1,$xx2,$yy2) = get_board_xxyy(@_);

	my($p_xx1,$p_yy1) = ($xx1 - 7, $yy - 7);
	print qq#<rect x="$p_xx1" y="$p_yy1" width="40" height="400" stroke="black" fill="black"></rect>#;

	for($i=$x1;$i<=$x2;$i++){
		for($j=$y1;$j<=$y2;$j++){
			$p_xx = $p_xx1 + ($i-21)*20+1;
			$p_yy = $p_yy1 + ($j-1)*20+1;
			$c_xx = $p_xx + 9;
			$c_yy = $p_yy + 9;
	print qq#<rect x="$p_xx" y="$p_yy" width="18" height="18" stroke="white" fill="none"></rect>#;
	print qq#<circle cx="$c_xx" cy="$c_yy" r="3" fill="gold" />#;
		}
	}
}

sub put_ic{
	shift;
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
	shift;
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
	shift;
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
	shift;
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
		$xx = $x * $w + 15 + ($x >= 2)*285 + $xx_offset;
		$y = 0 if($y >= 25);
		$yy = $y * 20 + 35 + int($y /5) * 20 + $yy_offset;
	}elsif($x < 20){
		my $w = 19;
		$xx = $x * $w + 10 + ($x >= 9)*32 + $xx_offset;
		$yy = $y * 20 + 30 + $yy_offset;
	}else{
		my $w = 20;
		$xx = ($x-20) * $w + 120;
		$yy = $y   * 20 + 60 + 40;
	}
	return ($xx,$yy);
}
' $@`

cat <<EOL > /tmp/tmp.svg

$a

EOL
inkscape -z -e out.png /tmp/tmp.svg
