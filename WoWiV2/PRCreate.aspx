<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <input type="hidden" name="refresh_type" value="" />
  <input type="hidden" name="item_id" value="" />
  <input type="hidden" name="c_date" value="10/13/2011" />
  <input type="hidden" name="cuser" value="netdb" />
  <input type="hidden" name="m_date" value="" />
  <input type="hidden" name="muser" value="" />
  <table border="0" cellspacing="0" cellpadding="2" align="left" width="100%">
    <tr><td>
      <table border="0" cellspacing="0" cellpadding="0" align="left" width="100%">
        <tr>
          <th align="left"><font size="+1">Purchase Request: 10881</font></th>
<td align="center"><input type="button" name="submitcmd" class="CCSBotton" value="PR View/Print" onClick="javascript:ViewPrint('PRPrint.asp?id=10881');" /></td>          
          <th align="Right"><font size="+1">Status: <select class="CCSTextBox" name="approval_status" style="font-family : ariel; font-size : 8pt" ><option value="1" selected="selected">Draft</option><option value="2">Waiting Approval</option><option value="3">Approved</option><option value="4">Disapproved</option><option value="5">Void</option></select>
</font></th>
        </tr>
        <tr><td colspan="2" class="ErrorText"></td></tr>
      </table>
    </td></tr>
    <tr><td><hr style="color:black;" /></td></tr>
    <tr><td>
      <table border="0" cellspacing="0" cellpadding="2" align="left" width="100%">
       <colgroup><col width="12%" align="left"><col width="12%" align="left">
                 <col width="12%" align="left"><col width="12%" align="left">
                 <col width="12%" align="left"><col width="12%" align="left">
                 <col width="12%" align="left"><col width="12%" align="left">
       </colgroup>
       <tr>
         <th>Profit Center:&nbsp;</th>
         <td><select class="CCSTextBox" name="profit_center" style="font-family : ariel; font-size : 8pt" ><option value="3">I</option></select>
</td>
         <th>Require PO:</th>
         <td><input class="CCSTextBox" type="checkbox" name="need_po" value="Y" /></td>
         <th><font color="red">*&nbsp;</font>Payment Type:&nbsp;</th>
         <td><select class="CCSTextBox" name="paymentmethod" style="font-family : ariel; font-size : 8pt" ><option value="0">-Select One</option><option value="4">Check</option><option value="3">COD</option><option value="9">Credit Card:Bjudge WF</option><option value="6">Credit Card:Mkuo AM</option><option value="1">Credit Card:Mkuo WF</option><option value="11">Credit Card:Sophia</option><option value="8">Credit Card:Swang AM</option><option value="7">Credit Card:Swang WF</option><option value="10">Credit Card:Ttran WF</option><option value="2">Pay by term</option><option value="5">Reimbursement</option></select>
</td>         
         <th>Net:&nbsp;</th>
         <td><input class="CCSTextBox" type="text" name="net" value="0" size="3" maxlength="3" /></td> 
       </tr>
       <tr>
         <th><font color="red">*&nbsp;</font>Expense Dept.:&nbsp;</th>
         <td><select class="CCSTextBox" name="budget_cat" style="font-family : ariel; font-size : 8pt" onchange="SubmitForm('dept');"><option value="0">- Select one</option><option value="1">IMA</option><option value="2">SALES</option><option value="3">ADM</option></select>
</td>                
         <th>For Quotation:&nbsp;</th>
         <td><select class="CCSTextBox" name="quotid" style="font-family : ariel; font-size : 8pt" ><option value="0">- Select one</option><option value="I1110170">I1110170</option><option value="I1110169">I1110169</option><option value="I1110168">I1110168</option><option value="I1110167">I1110167</option><option value="I1110165">I1110165</option><option value="I1110164">I1110164</option><option value="I1110163">I1110163</option><option value="I1110161">I1110161</option><option value="I1110160">I1110160</option><option value="I1110159">I1110159</option><option value="I1110158">I1110158</option><option value="I1110157">I1110157</option><option value="I1110156">I1110156</option><option value="I1110155">I1110155</option><option value="I1110154">I1110154</option><option value="I1110153">I1110153</option><option value="I1110152">I1110152</option><option value="I1110151">I1110151</option><option value="I1110150">I1110150</option><option value="I1110149">I1110149</option><option value="I1110148">I1110148</option><option value="I1110147">I1110147</option><option value="I1110143">I1110143</option><option value="I1110142">I1110142</option><option value="I1110137">I1110137</option><option value="I1110136">I1110136</option><option value="I1110134">I1110134</option><option value="I1110133">I1110133</option><option value="I1110132">I1110132</option><option value="I1110131">I1110131</option><option value="I1110130">I1110130</option><option value="I1110129">I1110129</option><option value="I1110128">I1110128</option><option value="I1110127">I1110127</option><option value="I1110126">I1110126</option><option value="I1110125">I1110125</option><option value="I1110124">I1110124</option><option value="I1110123">I1110123</option><option value="I1110120">I1110120</option><option value="I1110118">I1110118</option><option value="I1110117">I1110117</option><option value="I1110116">I1110116</option><option value="I1110115">I1110115</option><option value="I1110114">I1110114</option><option value="I1110113">I1110113</option><option value="I1110112">I1110112</option><option value="I1110111">I1110111</option><option value="I1110110">I1110110</option><option value="I1110109">I1110109</option><option value="I1110108">I1110108</option><option value="I1110107">I1110107</option><option value="I1110106">I1110106</option><option value="I1110105">I1110105</option><option value="I1110104">I1110104</option><option value="I1110103">I1110103</option><option value="I1110102">I1110102</option><option value="I1110101">I1110101</option><option value="I1110100">I1110100</option><option value="I1110099">I1110099</option><option value="I1110098">I1110098</option><option value="I1110097">I1110097</option><option value="I1110096">I1110096</option><option value="I1110095">I1110095</option><option value="I1110094">I1110094</option><option value="I1110093">I1110093</option><option value="I1110092">I1110092</option><option value="I1110091">I1110091</option><option value="I1110090">I1110090</option><option value="I1110089">I1110089</option><option value="I1110088">I1110088</option><option value="I1110087">I1110087</option><option value="I1110086">I1110086</option><option value="I1110085">I1110085</option><option value="I1110084">I1110084</option><option value="I1110083">I1110083</option><option value="I1110082">I1110082</option><option value="I1110081">I1110081</option><option value="I1110080">I1110080</option><option value="I1110079">I1110079</option><option value="I1110078">I1110078</option><option value="I1110077">I1110077</option><option value="I1110076">I1110076</option><option value="I1010075">I1010075</option><option value="I1010074">I1010074</option><option value="I1010073">I1010073</option><option value="I1010072">I1010072</option><option value="I1010071">I1010071</option><option value="I1010070">I1010070</option><option value="I1010069">I1010069</option><option value="I1010068">I1010068</option><option value="I1010067">I1010067</option><option value="I1010066">I1010066</option><option value="I1010065">I1010065</option><option value="I1010064">I1010064</option><option value="I1010063">I1010063</option><option value="I1010062">I1010062</option><option value="I1010061">I1010061</option><option value="I1010060">I1010060</option><option value="I1010059">I1010059</option><option value="I1010058">I1010058</option><option value="I1010057">I1010057</option><option value="I1010056">I1010056</option><option value="I1010055">I1010055</option><option value="I1010054">I1010054</option><option value="I1010053">I1010053</option><option value="I1010050">I1010050</option><option value="I1010049">I1010049</option><option value="I1010048">I1010048</option><option value="I1010047">I1010047</option><option value="I1010046">I1010046</option><option value="I1010045">I1010045</option><option value="I1010044">I1010044</option><option value="I1010043">I1010043</option><option value="I1010042">I1010042</option><option value="I1010041">I1010041</option><option value="I1010040">I1010040</option><option value="I1010039">I1010039</option><option value="I1010038">I1010038</option><option value="I1010037">I1010037</option><option value="I1010036">I1010036</option><option value="I1010035">I1010035</option><option value="I1010034">I1010034</option><option value="I1010033">I1010033</option><option value="I1010032">I1010032</option><option value="I1010031">I1010031</option><option value="I1010030">I1010030</option><option value="I1010029">I1010029</option><option value="I1010028">I1010028</option><option value="I1010027">I1010027</option><option value="I1010026">I1010026</option><option value="I1010025">I1010025</option><option value="I1010024">I1010024</option><option value="I1010023">I1010023</option><option value="I1010022">I1010022</option><option value="I0910021">I0910021</option><option value="I0910020">I0910020</option><option value="I0910019">I0910019</option><option value="I0910018">I0910018</option><option value="I0910017">I0910017</option><option value="I0910016">I0910016</option><option value="I0910015">I0910015</option><option value="I0910014">I0910014</option><option value="I0910013">I0910013</option><option value="I0910012">I0910012</option><option value="I0910011">I0910011</option><option value="I0910010">I0910010</option><option value="I0910009">I0910009</option><option value="I0910008">I0910008</option><option value="I0910007">I0910007</option><option value="I0910006">I0910006</option><option value="I0910005">I0910005</option><option value="I0910003">I0910003</option><option value="I0910002">I0910002</option><option value="U0910001">U0910001</option><option value="U0910000">U0910000</option></select>
</td>         
         <th>Vendor Quote#:&nbsp;</th>
         <td><input class="CCSTextBox" type="text" name="vendor_quot" value="" size="16" maxlength="16" /></td> 
         <th>&nbsp;</th>
         <td>&nbsp;</td>
       </tr>
       <tr>
         <th align="left">Quote Attached:&nbsp;</th>
         <td colspan="7">
           <table>
<tr><td></td></tr>                         
           </table>
         </td>
       </tr>              
       
       <tr><td colspan="8">&nbsp;</td></tr>
       <tr><th colspan="8">Vendor: <select class="CCSTextBox" name="vendor_id" style="font-family : ariel; font-size : 8pt" onchange="SubmitForm('vendor');"><option value="0">-Select One</option><option value="132">||</option><option value="134">||</option><option value="156">||</option><option value="160">||</option><option value="163">||</option><option value="168">||</option><option value="170">||</option><option value="171">||</option><option value="188">||</option><option value="194">||</option><option value="196">||</option><option value="213">||</option><option value="217">||</option><option value="215">||</option><option value="216">|02-26682591|</option><option value="80"> 丞緯科技股份有限公司||段貴麒</option><option value="63">5M Global Regulatory Compliance Specialists MEA||Murali Raghavan</option><option value="16">全國公證檢驗股份有限公司|02-6602 2888|</option><option value="115">創安科技顧問股份有限公司|(02)2912-5752 |</option><option value="110">力梭資訊股份有限公司|(02)8969-0901|鄭禮漢</option><option value="141">勤業眾信聯合會計師事務所|25459988|鄭淂蓁</option><option value="176">南山人壽保險股份有限公司|0932-061-092|</option><option value="166">台灣德國萊因技術監護顧問股份有限公司|2172-7000|李延敏 Carol lee</option><option value="187">台灣手工業推廣中心|23933655#201|</option><option value="58">君格事業有限公司|0933942342|何國曦</option><option value="48">喜唯旅行社|7701-5666|黃台禮</option><option value="17">天矽科技股份有限公司|02-8990-4080|</option><option value="207">奇摩購物中心||</option><option value="140">好事多股份有限公司內湖分公司||</option><option value="123">富華旅行社有限公司|02-2752-5901|</option><option value="165">小馬小客車租賃股份有限公司|02-25462888|</option><option value="130">一零四資訊科技股份有限公司|02-2912-6104|張伊涵</option><option value="218">三峽皇后鎮森林||02-26682591</option><option value="162">三軍總醫院||</option><option value="131">中華民國紅十字會台北市分會||</option><option value="26">中華電信台中營運處|04 2344-7955|黃聰銘</option><option value="202">康福旅行社股份有限公司 (可樂旅遊) Colatour|TEL:02-2658-2277|Vivi Hung 洪綺蔚</option><option value="66">康福旅行社高雄分公司|07-330-9788  分機 662|林象昌 ELEPHANT LIN</option><option value="7">佳信空調機電有限公司|(02)8685-1756|</option><option value="138">快特電波股份有限公司|02-87926808|Jacky Huang</option><option value="98">ADN Trading & Services|+60389550048|Adli bin Amirudin </option><option value="127">挪威商聯廣驗證股份有限公司台灣分公司| +886 2 8797 8790|</option><option value="23">捷柏資訊股份有限公司 (Fastwin)|02-2507-9808|</option><option value="212">探險家有限公司|0933-210-082|林 冠 穎      Dave</option><option value="190">故宮網路商城|(02)28812021|</option><option value="175">方正國際旅行社股份有限公司|0277020286|林象昌</option><option value="6">昇勁科技有限公司|(02)8780-2820|林清良</option><option value="59">昌德出版社|02-25537580|姚小姐</option><option value="146">東研信超股份有限公司|26573299|呂宜珊</option><option value="73">派絢視覺整合有限公司|0936-332-215|aponlin</option><option value="38">Agence Nationale de Reglementation des Telecommunications (ANRT)||BELKHADIR Abdelkarim</option><option value="101">Al Araab United General Trading and Contracting Co. W.L.L.|+965-24312300|Sreenath.M.R.</option><option value="139">AL- Seeb Technical Establishment (SARCO)|0096824709171|Anup Dev Roy</option><option value="133">Al-Seiko Import & Trading Co|970 599315933|En.Saed Tubaileh</option><option value="112">Aman For Modern Technologies(AMTjo)|+962-6553-7170|</option><option value="14">Approval Specialists Pty Ltd|+61(0)2 98826500|</option><option value="68">Approve-It! Inc.|Tel: +651-324-6941|Mr. Peter Grinager</option><option value="88">Art of Compliance (AoC)|(719) 357-7503|Jason Song</option><option value="210">ART&P (Togo)|| Monsieur Ayayi</option><option value="103">Asia Express Certification Services|+6016-3828675 |MUHAMMAD NAJELI MD NORANI</option><option value="62">Asuncion Granados Park Hotel||</option><option value="55">ASYNC Resources||Aminuddin Bin Ahmad Marzuri(Amin)</option><option value="92">AT4 wireless, S.A. | (34) 95 261 93 17   |Mª Gema Briseño Pascual </option><option value="159">Autoriteti Komunikimeve Elektronike dhe Postare|0035542259571|Mr. Ylli Dode</option><option value="183">Azalaï Hotel Salam|223 2221200|</option><option value="209">Bénin Services Consulting |+229 97922818|Joscar AGBO</option><option value="84">燦坤實業股份有限公司||</option><option value="189">福星茶行|02-29157013|</option><option value="22">禾欣電腦股份有限公司 (筆電王)|04-2218-1098|林先生</option><option value="25">紀藝設計工作室|02 22443218|林先生</option><option value="64">統一數位翻譯|+886-2-87916688#820/821|James Chen</option><option value="70">Clarion Hotel Tecgucigalpa|+504-286-6000|</option><option value="158">Codyson Jaya, cv|+62 21-75875237|Yohannes GB Anggoro</option><option value="126">COMMUNICATIONS COMMISSION OF KENYA||Njeri, Mwangi</option><option value="120">Compliance Certification Services Inc. |02-2217-1322 #21 |Eddy Chiu 邱政華 新店LAB</option><option value="69">ComWorks, Inc.|+6329525256|Roberto Banzon </option><option value="57">CV. DIMULTI|+622132608337|Umbul Narmadi</option><option value="136">DCS Laboratory, SRL|+3732 446395|Eugune Lazarev</option><option value="31">Distant Support Virtual Assistant|63-9285519632|Jonathan Gabriel </option><option value="144">耑維科技股份有限公司|02-27163636|李彥霖</option><option value="24">連邦國際專利商標事務所|02 2564-2565|張敬業</option><option value="76">臺灣臺北地方法院所屬民間公證人陳幼麟謝孟儒聯合事務所|02-2719-7889|</option><option value="94">解構國際有限公司|0932-147-321|李世敬</option><option value="153">財團法人創世社會福利基金會|2396-7777|</option><option value="60">財團法人電信技術中心|+886-2-2658-9958 Ext 201|Jerry Tsai (蔡皆得)</option><option value="203">資設通信有限公司||陳錦河0936-129220</option><option value="119">EH COnsultancy Services Pvt. Ltd.|+977-9851117555|Mr. Naresh Pradhan</option><option value="75">Electronic Al-Baheth Center |009626553493 |Tamer Alzoubi </option><option value="208">ELITE VOYAGES|+226 50303154|</option><option value="169">Elmas Limited| +7 495 7816395|Alexey Luchenko</option><option value="3">Global Certification Pte Ltd.|+65-6260 1495|Sharon Hsiung</option><option value="214">Global Services Guinee|+224 68 92 49 46/+224 66 94 91 1|Mr Francois LAMA</option><option value="116">GOHAPPY線上快樂購||</option><option value="83">Google Services ||</option><option value="74">Gost-Asia Pte Ltd. | +65-6777-2889|Andrew Chew</option><option value="36">Grilsa|52 55 5516 1618|Eduardo Lozano O.</option><option value="15">Grupo Industrial Lozano|52 55 5516 1618|</option><option value="56">Hernandez & Grimberg| +56-9-9327-6238|Maria Pilar Hernandez</option><option value="182">Holiday Inn Ghana||+233 21785324</option><option value="61">Holiday Inn Montevideo|+592 29020001|</option><option value="205">Hotel Crowne Plaza Managua (Nicaragua)||</option><option value="71">Hotel Grano de Oro|+506-2255-3322|</option><option value="179">Hotel Novotel Cotonou Orisha|Tel (+229)21/305662|Mr Jean-Luc BRECHEMIER</option><option value="201">Hotel Parque Central|(+537) 864 9177 |Diana Monzon</option><option value="178">iBEC (Instituto Brasileiro de Ensaios de Conformidade Ltda.|+55(19)3845-5965|Regis Tanaka</option><option value="27">INDEPENDENT COMMUNICATIONS AUTHORITY OF SOUTH AFRICA (ICASA)|+27 115663843|Mark Deavall</option><option value="147">Infocomm Development Authority of Singapore||</option><option value="108">Innovation, SARL|+245 660 15 53|Nérida N. M. Batista Fonseca</option><option value="20">INNOVIS SINGAPORE ENTERPRISE (ISE)| +6016-699-7064|Kenny Mok</option><option value="19">International Accreditation Veritas|+(91)-(11)-22734|Sandeep Narula</option><option value="122">International Compliance Management|+44 (0)1482 668836|Mark Boughen</option><option value="53">International Products Group Co., Ltd|+66 (0) 2577-313|Sittichat Treephong</option><option value="118">Intertek Testing Services (Singapore) Pte Ltd.|+65 6281 1060|Mr. Brian Tee</option><option value="204">IPersat Cameroon|+237 22 00 18 19 / 77 77 58 77|Mr. Franck FOKAM</option><option value="148">IQSCO|0098 (0) 21 44 47 59 89-91|Fallah Rostami</option><option value="33">JSC Mir Tele Test|+7(495)957-70-36|Anantoly Fadeev</option><option value="52">Jularbal Andawi & Esteban Attorneys-at-law|+63920-9514424|</option><option value="8">Kun Chi Computer Co., Ltd.|02-2391-0758|</option><option value="13">Laboratorios Unidos S.A.||</option><option value="181">LAICO Ouaga 2000  Hotel|+226 76 86 26 90|General Manager Maher Ghidaou</option><option value="91">Liberia Telecommunications Authority (LTA)|+231(0)27302019|Emmanuel J. Payegar</option><option value="206">Lidotel Caracas (Venezuela)||</option><option value="128">Linguitronics Co., Ltd.| +886 (2) 2740-0706|Melody Huang</option><option value="12">lng. ERNESTO C. ROCHA|(011)4452 7426|</option><option value="164">M SAN GRUPA d.d.|+385 1 6690 724|Mirta Svoboda Grahovac</option><option value="117">María Teresa Pintos|+ 59824863662 |María Teresa Pintos</option><option value="193">Master Associacao de Avaliacao de Conformidade|+55 (19)3241-7580|Maristela R. Bento</option><option value="150">Microinform Burundi||Nestor MISIGARO </option><option value="173">Ministry of Foreign Affairs of the Republic of Armenia|(+374 10) 544041|Ministry of Foreign Affairs of the Republic of Armenia</option><option value="11">Mobility FZ LLC|+971 4 3913264|Nabil</option><option value="192">Nano Technology Pvt. Ltd.|+977-9851117555|Naresh Pradhan</option><option value="142">National Communications Authority (Ghana)||</option><option value="135">National Radiofrequency Centre, The Ministry of Information Technologies and Communications of the Republic of Moldova|+373 22 735 394|</option><option value="161">NATIONAL REGULATOR FOR COMPULSORY SPECIFICATIONS|+27124286477|Elsabe Kok</option><option value="46">National Telecom Regulatory Authority (NTRA Egypt)|+202 353 44024|Mohamed Hossam Hegazy</option><option value="121">National Telecommunications Commission (NATCOM)||Mr. Steven Konteh</option><option value="191">Neton Project Limited |+447954391412|Roy Michaels</option><option value="114">Netzigim Laboratories and office automation ltd.|+972- 3-9214646|Itay Roth</option><option value="154">NEW TECHNOLOGY MALI|+223 20 21 55 41 |Abdoul Kadri BOUARE</option><option value="85">Nigerian Communications Commission (NCC)|234-9-4617000|Mr. Alkali Mohammed</option><option value="200">NTRC-ECTEL (Dominica)|767 266 3096|George James</option><option value="49">Omega State Test Centre|0692 24 03 73|Aleksey Vladimirovich Shelegin</option><option value="184">Onomo Dakar Airport|+221 33 869 06 10|</option><option value="29">Orbiter, Inc.|408 693-5907|Wesley Chong</option><option value="67">Pakistan Telecommunication Authority|051-9207079|Abdul Wahid Khalil</option><option value="172">Passport Visa Express.com, Inc.||Dee Manurung</option><option value="186">PCHome||</option><option value="137">PointNet Gabon|+241 07 599393 |Mme. BOLATITO Easther AYEYE</option><option value="10">Product Compliance Specialists, Ltd|+44 1844 273277|Gemma McGough</option><option value="32">Products Application Center CO.,Ltd.|(66 2)957 8842|EkkaraK Pilakerd</option><option value="21">Proxus Communication Pte Ltd|65-97301434|Clemence Sim </option><option value="54">PT. PURBATELINDO|+6221-46559338|DIDI MARDI PURBA</option><option value="72">PT. PUTRA NAGITA PRATAMA|+622187708270|Kosmos Bangun</option><option value="197">PTE 臺北簽證中心|0225815256|許麗雯</option><option value="90">Public Utilities Regulatory Authority|+220 4465177|Mr. Rodine Renner</option><option value="151">QUALICIEL-IT BURKINA||COMBARY YENTOUGUILI CLEMENT</option><option value="129">Radioscan LLC Certification Body|+37410-237392|Henry Martirosyan</option><option value="157">Rassim Ibrahimov|+99412-4974040|Rassim Ibrahimov</option><option value="167">Rassim Ibrahimov|+99412-4974040|Rassim Ibrahimov</option><option value="107">Realtime Telecommunication|+212 6 73 72 13 05|Bouchra zaoui</option><option value="211">Republic Agency for Electronic Communications|381-11-2026-887|Ljubica Markovic</option><option value="152">Richard Li|1-415-728-7644|</option><option value="125">Roland LAOUALY|+221 77 569 6295|ROLAND LAOUALY</option><option value="143">Rubén Sosa|+595-971-200205|Ing. Rubén Sosa</option><option value="149">SABS COMMERCIAL (PTY) LTD|012 428 6715|Mr. Eddie Naude</option><option value="79">San Chen|+1 408 888 5891|San Chen</option><option value="87">SELDEN ALLIANCE,INC|+7(495)921-3411|Dr. Sergey V. Melnik</option><option value="93">SERVETCH|+21623521733|Mr. Ettaieb Slim</option><option value="77">SGEIB|216 97  113 363|Mr. Ettaieb Slim</option><option value="185">Sheraton Abuja|(234) (0) 9 4612000|</option><option value="5">Sigma International Technologies Co., Ltd.|(02) 2918-5879|</option><option value="109">Soc. Comercial y de servicios Emebe Ltda|76630870-8|Miguel Mora</option><option value="1">Sunren Technical Solutions Pvt. Ltd.|+91 22 24055281|Sunil Shenoy</option><option value="113">Superintendencia de Telecomunicaciones(Ecuador)|(+593) 2 2946400|Diego Uribe</option><option value="9">T.S.G 網路國際集團|02-8990-4080|</option><option value="78">Tanzania Communications Regulatory Authority (TCRA)|+255 655 511 411|Eng. Kibacha</option><option value="199">TELCOR Nicaragua|(505)22227348|Ileana Alvarez</option><option value="95">TELECOM & MORE TECHNOLOGIE sprl|+243852963436|Mr. Eperant KUAZAMBI</option><option value="47">Telecommunication Regulatory Authority (Oman)|+968 24574300|Eng. Ibrahim Al-Mawali</option><option value="39">Telecommunication Regulatory Authority (UAE)|+971 4 428 8872|Mr. Mohammed Alshehi</option><option value="111">Telset Ltd. |+7-727-292-19-11|Kulikova Elena</option><option value="50">Testsvyaz, Scientific Testing Center; Limited company|0692 24 03 73|Aleksey</option><option value="198">Uganda Communications Commission|+256-312-339000/+256-414-339000 |Echeda Robert </option><option value="2">Versus Technology (JJ Nel Consulting Pty Ltd)| +27 83 5140 709|Jean J Nel</option><option value="106">Webramp Communication & Services|+63 916 4396216|</option><option value="195">Zambia information and communication technology authority |+260 21 1244424|Mr. Elliot Nketani Kabalo</option></select>
</th></tr>       
       <tr>
         <th colspan="8">
         Vendor Name: <input class="CCSTextBox" type="text" name="vendor_name" value="" size="33" maxlength="100" />
         Tel: <input class="CCSTextBox" type="text" name="vendor_tel" value="" size="13" maxlength="32" />
         Ext: <input class="CCSTextBox" type="text" name="vendor_ext" value="" size="4" maxlength="10" />         
         Account#: <input class="CCSTextBox" type="text" name="vendor_acct" value="" size="10" maxlength="32" />         
         Contact Person: <input class="CCSTextBox" type="text" name="vendor_contact" value="" size="25" maxlength="64" />
         <input type="hidden" name="vendor_fax" value="" />         
         <input type="hidden" name="vendor_addr" value="" />         
         <input type="hidden" name="vendor_city" value="" />         
         <input type="hidden" name="vendor_state" value="" />         
         <input type="hidden" name="vendor_zip" value="" />                  
         </th>
       </tr>
       <tr>
          <th colspan="8">
          Date Delivered: <input class="CCSTextBox" type="text" name="date_delivered" value="" size="8" maxlength="10" />
          &nbsp;&nbsp;&nbsp;&nbsp;Freight Paid by Vendor: <input class="CCSTextBox" type="checkbox" name="freight_paid_by_vendor" value="Y" />
          &nbsp;&nbsp;&nbsp;&nbsp;Ship method: <select class="CCSTextBox" name="shipping_method_id" style="font-family : ariel; font-size : 8pt" ><option value="0">-Select One</option><option value="1">UPS Ground</option><option value="2">UPS 1 Day</option><option value="3">UPS 2 Days</option><option value="4">FedEx Ground</option><option value="5">FedEx 1 Day</option><option value="6">FedEx 2 Days</option><option value="7">DHL Ground</option><option value="8">DHL Air</option><option value="9">USPS</option><option value="10">Will Call</option><option value="11">Hand Delivery</option></select>
<br>
          Ship to: <select class="CCSTextBox" name="shipping_addr_id" style="font-family : ariel; font-size : 8pt" onchange="SubmitForm('ship_to');"><option value="0">-Select One</option><option value="1">MH</option><option value="2">TW</option><option value="3">FM</option></select>

          <input class="CCSTextBox" type="text" name="shipping_addr" value="" size="60" maxlength="63" />
          </th>
       </tr>       
      </table>
    </td></tr> 
<tr><td>                                     
  <table border="1" cellspacing="0" cellpadding="0" align="left" width="100%">
  <colgroup><col width="3%">
            <col align="left" width="36%">
            <col width="5%">
            <col align="center" width="4%">
            <col align="right" width="8%">
            <col align="center" width="3%">
            <col width="6%">
            <col width="6%">
            <col align="right" width="8%">
            <col width="20%"></colgroup>
       <tr align="center" bgcolor="#c6eff7">
         <th>Del</th>                 
         <th>&nbsp;Item Description</th>          
         <th>Part/M#</th>
         <th>Asset</th>
         <th>Price</th>
         <th>Qty</th>
         <th colspan="2">Rental Period</th>
         <th>Amount</th>   
<!--         <th>Budget Category</th>             -->
               
       </tr>
  </table>
</td></tr>
<tr><td>                                     
  <table border="1" cellspacing="0" cellpadding="0" align="left" width="100%">
  <colgroup><col valign="top" align="left" width="27%">
            <col valign="top" width="8%">
            <col valign="top" width="5%">
            <col valign="top" width="6%">
            <col valign="top" width="3%">
            <col valign="top" width="18%">
            <col valign="top" width="6%">
            <col valign="top" width="27%" align="left"></colgroup>  
       <tr align="center" bgcolor="#c6eff7">
         <th>&nbsp;Item Description</th>          
         <th>Part/M#</th>
         <th>Asset</th>
         <th>Price</th>
         <th>Qty</th>
         <th>Rental Period</th>
         <th>Amount</th>  
<!--         <th>Budget Category</th>         -->
       </tr>
       <tr align="center" bgcolor="#c6eff7">
         <td><input class="CCSTextBox" type="text" name="item_desc" value="" size="35" maxlength="75" /></td>          
         <td><input class="CCSTextBox" type="text" name="part_no" value="" size="7" maxlength="26" /></td>       
         <td><input class="CCSTextBox" type="checkbox" name="isasset" value="Y"  onclick="CalPricing();" /></td>
         <td><input class="CCSNumberBox" type="text" name="unit_price" value="" size="7" maxlength="10" onchange="CalPricing();" /></td>
         <td><input class="CCSTextBox" type="text" name="quantity" value="" size="2" maxlength="3" onchange="CalPricing();" /></td>
         <th><input class="CCSTextBox" type="text" name="rental_from" value="" size="10" maxlength="16" />
             <input class="CCSTextBox" type="text" name="rental_to" value="" size="10" maxlength="16" />
         </th>
         <td><input class="CCSNumberBoxRD" type="text" name="gross_amount" value="" size="7" maxlength="10" readonly /></td>         
<!--         <td><select class="CCSTextBox" name="expense_cat" style="font-family : ariel; font-size : 8pt" ><option value="0">- Select one</option></select>
</td>        -->
       </tr>       
  </table>
</td></tr>
<tr><td>                                     
  <table border="0" cellspacing="0" cellpadding="0" align="left" width="100%">
  <colgroup><col align="left" width="52%"><col width="30%"><col width="18%"></colgroup>  
  <tr>
    <td valign="top">
      <table border="0" cellspacing="0" cellpadding="0" align="left" width="100%">
        <tr><th>Requisitioner:</th>
            <th><input type="submit" name="submit_requisitioner_approval" class="CCSBotton" value="Send Request" onclick="return confirm('Send request?');" /></th>
            <th><select class="CCSTextBox" name="request_to" style="font-family : ariel; font-size : 8pt" ><option value="76" selected="selected">skang</option></select>
</th>            
            <th><input class="CCSTextBox" type="text" name="requisitioner_approval" value="" size="1" />
            <td><input class="CCSTextBox" type="text" name="requisitioner" value="netdb" size="10" /></td>
            <th>Date:&nbsp;&nbsp;<input class="CCSTextBox" type="text" name="requisitioner_date" value="10/13/2011" size="10" /></th>
        </tr>
        <tr><th>Supervisor:</th>
            <th><input type="submit" name="submit_supervisor_approval" class="CCSBotton" value="Approve" onclick="return confirm('Approve?');" /></th>
            <th><input type="submit" name="submit_supervisor_approval" class="CCSBotton" value="Disapprove" onclick="return confirm('Disapprove?');" /></th>            
            <th><input class="CCSTextBox" type="text" name="supervisor_approval" value="" size="1" />            
            <td><input class="CCSTextBox" type="text" name="supervisor" value="" size="10" /></td>
            <th>Date:&nbsp;&nbsp;<input class="CCSTextBox" type="text" name="supervisor_date" value="" size="10" /></th>
        </tr>
        <tr><th>Manager:</th>
            <th><input type="submit" name="submit_manager_approval" class="CCSBotton" value="Approve" onclick="return confirm('Approve?');" /></th>
            <th><input type="submit" name="submit_manager_approval" class="CCSBotton" value="Disapprove" onclick="return confirm('Disapprove?');" /></th>                    
             <th><input class="CCSTextBox" type="text" name="manager_approval" value="" size="1" /> 
            <td><input class="CCSTextBox" type="text" name="manager" value="" size="10" /></td>
            <th>Date:&nbsp;&nbsp;<input class="CCSTextBox" type="text" name="manager_date" value="" size="10" /></th>
        </tr>
        <tr><th>VP:</th>
            <th><input type="submit" name="submit_vp_approval" class="CCSBotton" value="Approve" onclick="return confirm('Approve?');" /></th>
            <th><input type="submit" name="submit_vp_approval" class="CCSBotton" value="Disapprove" onclick="return confirm('Disapprove?');" /></th>                    
            <th><input class="CCSTextBox" type="text" name="vp_approval" value="" size="1" /> 
            <td><input class="CCSTextBox" type="text" name="vp" value="" size="10" /></td>
            <th>Date:&nbsp;&nbsp;<input class="CCSTextBox" type="text" name="vp_date" value="" size="10" /></th>
        </tr>
        <tr><th>President:</th>
            <th><input type="submit" name="submit_president_approval" class="CCSBotton" value="Approve" onclick="return confirm('Approve?');" /></th>
            <th><input type="submit" name="submit_president_approval" class="CCSBotton" value="Disapprove" onclick="return confirm('Disapprove?');" /></th>                    
            <th><input class="CCSTextBox" type="text" name="president_approval" value="" size="1" /> 
            <td><input class="CCSTextBox" type="text" name="president" value="" size="10" /></td>
            <th>Date:&nbsp;&nbsp;<input class="CCSTextBox" type="text" name="president_date" value="" size="10" /></th>
        </tr>
        <tr><th>Finance Dept.:</th>
            <th>&nbsp;</th>
            <th>&nbsp;</th>            
            <th><input class="CCSTextBox" type="text" name="finance_approval" value="" size="1" />            
            <td><input class="CCSTextBox" type="text" name="finance" value="" size="10" /></td>
            <th>Date:&nbsp;&nbsp;<input class="CCSTextBox" type="text" name="finance_date" value="" size="10" /></th>
        </tr>        
        <tr><th>Cancel:</th>
            <th><input type="submit" name="submit_requisitioner_approval" class="CCSBotton" value="Withdraw" onclick="return confirm('Withdraw?');" /></th>
            <th>&nbsp;</th>            
            <th>&nbsp;</th>            
            <td>&nbsp;</td>
            <th>&nbsp;</th>
        </tr>        
      </table>
    </td>
<!--    <th align="left" valign="top">Internal Remarks (When you approve this, you may add additional comment here):<br />  -->
    <th align="left" valign="top">Internal Remarks:<br />    
      <textarea name="remark" rows="3" cols="32"></textarea><br />
      Instruction: <br />
      <textarea name="instruction" rows="3" cols="32"></textarea>
    </th>
    <td valign="top">
      <table border="0" cellspacing="0" cellpadding="0" align="right" width="100%">
        <colgroup><col align="right"><col align="left"></colgroup>
        <tr>
            <th>Sub Total: &nbsp;&nbsp;</th>
            <td>$<input class="CCSNumberBoxRD" type="text" name="sub_total" value="0" size="10" readonly /></td>            
        </tr>            
        <tr>
            <th>MISC: &nbsp;&nbsp;</th>
            <td>$<input class="CCSNumberBox" type="text" name="misc" value="0" size="10" onchange="SummCalPricing();" /></td>           
        </tr>      
        <tr>
            <th>Shipping: &nbsp;&nbsp;</th>
            <td>$<input class="CCSNumberBox" type="text" name="shipping" value="0" size="10" onchange="SummCalPricing();" /></td>            
        </tr>           
        <tr>
            <th>Tax <input class="CCSNumberBox" type="checkbox" name="taxcheck" value="Y" onclick="CalTax();" />: 
			&nbsp;&nbsp;</th>
            <td>$<input class="CCSNumberBox" type="text" name="tax" value="0" size="10" onchange="SummCalPricing();" /></td>
        </tr>               
        <tr>
            <th>Total: &nbsp;&nbsp;</th>
            <td>$<input class="CCSNumberBoxRD" type="text" name="total" value="0" size="10" readonly /></td>            
        </tr>                    
      </table>    
    </td>
  </tr>
  
  </table>
</td></tr>
<tr><td>                                     
  <table border="0" cellspacing="0" cellpadding="4" align="center" width="100%">
    <tr align="center">
    
      <td width="33%"><INPUT type="submit" NAME="Submit" value="Save & Attach" class="CCSBotton" /></td>
      <td width="33%"><input type="submit" name="Submit" class="CCSBotton" value="Save" /></td>               
      <td width="33%"><input type="submit" name="Submit" class="CCSBotton" value="Back" /></td>               
    
    </tr>
  </table>
</td></tr>     

<tr><td>

</td></tr>
      
  </table>
  <input type="hidden" name="prattachmentlist" value="0" />
</form>

    </form>
</body>
</html>
