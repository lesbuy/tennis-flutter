import 'package:coric_tennis/base/http_base.dart';
import 'package:flutter/material.dart';
import 'package:coric_tennis/base/pair.dart';
import 'package:transparent_image/transparent_image.dart';

String iocFlags(int h) {
  return "assets/images/flag/flags$h.webp";
}

String playerHeadshot(String pid) {
  return [staticRoot, "pic", "hs", pid].join("/");
}

String playerPortrait(String pid) {
  return [staticRoot, "pic", "pt", pid].join("/");
}

Map<String, Pair<double, double>> findMap = {
  "AFG": Pair(-1, -1),
  "AHO": Pair(-0.875, -1),
  "AIA": Pair(-0.75, -1),
  "ALA": Pair(-0.625, -1),
  "ALB": Pair(-0.5, -1),
  "ALG": Pair(-0.375, -1),
  "AND": Pair(-0.25, -1),
  "ANG": Pair(-0.125, -1),
  "ANT": Pair(0, -1),
  "ARG": Pair(0.125, -1),
  "ARM": Pair(0.25, -1),
  "ARU": Pair(0.375, -1),
  "ASA": Pair(0.5, -1),
  "ATA": Pair(0.625, -1),
  "ATF": Pair(0.75, -1),
  "AUS": Pair(0.875, -1),
  "AUT": Pair(-1, -0.875),
  "AZE": Pair(-0.875, -0.875),
  "BAH": Pair(-0.75, -0.875),
  "BAN": Pair(-0.625, -0.875),
  "BAR": Pair(-0.5, -0.875),
  "BDI": Pair(-0.375, -0.875),
  "BEL": Pair(-0.25, -0.875),
  "BEN": Pair(-0.125, -0.875),
  "BER": Pair(0, -0.875),
  "BES": Pair(0.125, -0.875),
  "BHU": Pair(0.25, -0.875),
  "BIH": Pair(0.375, -0.875),
  "BIZ": Pair(0.5, -0.875),
  "BLM": Pair(0.625, -0.875),
  "BLR": Pair(0.75, -0.875),
  "BOL": Pair(0.875, -0.875),
  "BOT": Pair(-1, -0.75),
  "BRA": Pair(-0.875, -0.75),
  "BRN": Pair(-0.75, -0.75),
  "BRU": Pair(-0.625, -0.75),
  "BUL": Pair(-0.5, -0.75),
  "BUR": Pair(-0.375, -0.75),
  "BVT": Pair(-0.25, -0.75),
  "CAF": Pair(-0.125, -0.75),
  "CAL": Pair(0, -0.75),
  "CAM": Pair(0.125, -0.75),
  "CAN": Pair(0.25, -0.75),
  "CAY": Pair(0.375, -0.75),
  "CCK": Pair(0.5, -0.75),
  "CGO": Pair(0.625, -0.75),
  "CHA": Pair(0.75, -0.75),
  "CHI": Pair(0.875, -0.75),
  "CHN": Pair(-1, -0.625),
  "CIS": Pair(-0.875, -0.625),
  "CIV": Pair(-0.75, -0.625),
  "CMR": Pair(-0.625, -0.625),
  "COD": Pair(-0.5, -0.625),
  "COK": Pair(-0.375, -0.625),
  "COL": Pair(-0.25, -0.625),
  "COM": Pair(-0.125, -0.625),
  "CPV": Pair(0, -0.625),
  "CRC": Pair(0.125, -0.625),
  "CRO": Pair(0.25, -0.625),
  "CUB": Pair(0.375, -0.625),
  "CUW": Pair(0.5, -0.625),
  "CXR": Pair(0.625, -0.625),
  "CYP": Pair(0.75, -0.625),
  "CZE": Pair(0.875, -0.625),
  "DEN": Pair(-1, -0.5),
  "DJI": Pair(-0.875, -0.5),
  "DMA": Pair(-0.75, -0.5),
  "DOM": Pair(-0.625, -0.5),
  "ECU": Pair(-0.5, -0.5),
  "EGY": Pair(-0.375, -0.5),
  "ERI": Pair(-0.25, -0.5),
  "ESA": Pair(-0.125, -0.5),
  "ESH": Pair(0, -0.5),
  "ESP": Pair(0.125, -0.5),
  "EST": Pair(0.25, -0.5),
  "ETH": Pair(0.375, -0.5),
  "FGU": Pair(0.5, -0.5),
  "FIJ": Pair(0.625, -0.5),
  "FIN": Pair(0.75, -0.5),
  "FLK": Pair(0.875, -0.5),
  "FRA": Pair(-1, -0.375),
  "FRO": Pair(-0.875, -0.375),
  "FSM": Pair(-0.75, -0.375),
  "GAB": Pair(-0.625, -0.375),
  "GAM": Pair(-0.5, -0.375),
  "GBR": Pair(-0.375, -0.375),
  "GBS": Pair(-0.25, -0.375),
  "GEO": Pair(-0.125, -0.375),
  "GEQ": Pair(0, -0.375),
  "GER": Pair(0.125, -0.375),
  "GGY": Pair(0.25, -0.375),
  "GHA": Pair(0.375, -0.375),
  "GIB": Pair(0.5, -0.375),
  "GRE": Pair(0.625, -0.375),
  "GRL": Pair(0.75, -0.375),
  "GRN": Pair(0.875, -0.375),
  "GUA": Pair(-1, -0.25),
  "GUD": Pair(-0.875, -0.25),
  "GUI": Pair(-0.75, -0.25),
  "GUM": Pair(-0.625, -0.25),
  "GUY": Pair(-0.5, -0.25),
  "HAI": Pair(-0.375, -0.25),
  "HKG": Pair(-0.25, -0.25),
  "HMD": Pair(-0.125, -0.25),
  "HON": Pair(0, -0.25),
  "HUN": Pair(0.125, -0.25),
  "IMN": Pair(0.25, -0.25),
  "INA": Pair(0.375, -0.25),
  "IND": Pair(0.5, -0.25),
  "IOT": Pair(0.625, -0.25),
  "IRI": Pair(0.75, -0.25),
  "IRL": Pair(0.875, -0.25),
  "IRQ": Pair(-1, -0.125),
  "ISL": Pair(-0.875, -0.125),
  "ISR": Pair(-0.75, -0.125),
  "ISV": Pair(-0.625, -0.125),
  "ITA": Pair(-0.5, -0.125),
  "IVB": Pair(-0.375, -0.125),
  "JAM": Pair(-0.25, -0.125),
  "JEY": Pair(-0.125, -0.125),
  "JOR": Pair(0, -0.125),
  "JPN": Pair(0.125, -0.125),
  "KAZ": Pair(0.25, -0.125),
  "KEN": Pair(0.375, -0.125),
  "KGZ": Pair(0.5, -0.125),
  "KIR": Pair(0.625, -0.125),
  "KOR": Pair(0.75, -0.125),
  "KOS": Pair(0.875, -0.125),
  "KSA": Pair(-1, 0),
  "KUW": Pair(-0.875, 0),
  "LAO": Pair(-0.75, 0),
  "LAT": Pair(-0.625, 0),
  "LBA": Pair(-0.5, 0),
  "LBN": Pair(-0.375, 0),
  "LBR": Pair(-0.25, 0),
  "LCA": Pair(-0.125, 0),
  "LES": Pair(0, 0),
  "LIE": Pair(0.125, 0),
  "LTU": Pair(0.25, 0),
  "LUX": Pair(0.375, 0),
  "MAC": Pair(0.5, 0),
  "MAD": Pair(0.625, 0),
  "MAF": Pair(0.75, 0),
  "MAR": Pair(0.875, 0),
  "MAS": Pair(-1, 0.125),
  "MAW": Pair(-0.875, 0.125),
  "MDA": Pair(-0.75, 0.125),
  "MDV": Pair(-0.625, 0.125),
  "MEX": Pair(-0.5, 0.125),
  "MGL": Pair(-0.375, 0.125),
  "MHL": Pair(-0.25, 0.125),
  "MKD": Pair(-0.125, 0.125),
  "MLI": Pair(0, 0.125),
  "MLT": Pair(0.125, 0.125),
  "MNE": Pair(0.25, 0.125),
  "MON": Pair(0.375, 0.125),
  "MOZ": Pair(0.5, 0.125),
  "MRI": Pair(0.625, 0.125),
  "MRN": Pair(0.75, 0.125),
  "MSR": Pair(0.875, 0.125),
  "MTN": Pair(-1, 0.25),
  "MYA": Pair(-0.875, 0.25),
  "MYT": Pair(-0.75, 0.25),
  "NAM": Pair(-0.625, 0.25),
  "NCA": Pair(-0.5, 0.25),
  "NED": Pair(-0.375, 0.25),
  "NEP": Pair(-0.25, 0.25),
  "NFK": Pair(-0.125, 0.25),
  "NGR": Pair(0, 0.25),
  "NIG": Pair(0.125, 0.25),
  "NIU": Pair(0.25, 0.25),
  "NMI": Pair(0.375, 0.25),
  "NOR": Pair(0.5, 0.25),
  "NRU": Pair(0.625, 0.25),
  "NZL": Pair(0.75, 0.25),
  "OMA": Pair(0.875, 0.25),
  "PAK": Pair(-1, 0.375),
  "PAN": Pair(-0.875, 0.375),
  "PAR": Pair(-0.75, 0.375),
  "PCN": Pair(-0.625, 0.375),
  "PER": Pair(-0.5, 0.375),
  "PHI": Pair(-0.375, 0.375),
  "PLE": Pair(-0.25, 0.375),
  "PLW": Pair(-0.125, 0.375),
  "PNG": Pair(0, 0.375),
  "POL": Pair(0.125, 0.375),
  "POR": Pair(0.25, 0.375),
  "PRK": Pair(0.375, 0.375),
  "PUR": Pair(0.5, 0.375),
  "QAT": Pair(0.625, 0.375),
  "REU": Pair(0.75, 0.375),
  "ROU": Pair(0.875, 0.375),
  "RSA": Pair(-1, 0.5),
  "RUS": Pair(-0.875, 0.5),
  "RWA": Pair(-0.75, 0.5),
  "SAM": Pair(-0.625, 0.5),
  "SCG": Pair(-0.5, 0.5),
  "SEN": Pair(-0.375, 0.5),
  "SEY": Pair(-0.25, 0.5),
  "SGP": Pair(-0.125, 0.5),
  "SGS": Pair(0, 0.5),
  "SHN": Pair(0.125, 0.5),
  "SJM": Pair(0.25, 0.5),
  "SKN": Pair(0.375, 0.5),
  "SLE": Pair(0.5, 0.5),
  "SLO": Pair(0.625, 0.5),
  "SMR": Pair(0.75, 0.5),
  "SOL": Pair(0.875, 0.5),
  "SOM": Pair(-1, 0.625),
  "SPM": Pair(-0.875, 0.625),
  "SRB": Pair(-0.75, 0.625),
  "SRI": Pair(-0.625, 0.625),
  "SSD": Pair(-0.5, 0.625),
  "STP": Pair(-0.375, 0.625),
  "SUD": Pair(-0.25, 0.625),
  "SUI": Pair(-0.125, 0.625),
  "SUR": Pair(0, 0.625),
  "SVK": Pair(0.125, 0.625),
  "SWE": Pair(0.25, 0.625),
  "SWZ": Pair(0.375, 0.625),
  "SXM": Pair(0.5, 0.625),
  "SYR": Pair(0.625, 0.625),
  "TAH": Pair(0.75, 0.625),
  "TAN": Pair(0.875, 0.625),
  "TCA": Pair(-1, 0.75),
  "TCH": Pair(-0.875, 0.75),
  "TGA": Pair(-0.75, 0.75),
  "THA": Pair(-0.625, 0.75),
  "TJK": Pair(-0.5, 0.75),
  "TKL": Pair(-0.375, 0.75),
  "TKM": Pair(-0.25, 0.75),
  "TLS": Pair(-0.125, 0.75),
  "TOG": Pair(0, 0.75),
  "TPE": Pair(0.125, 0.75),
  "TTO": Pair(0.25, 0.75),
  "TUN": Pair(0.375, 0.75),
  "TUR": Pair(0.5, 0.75),
  "TUV": Pair(0.625, 0.75),
  "UAE": Pair(0.75, 0.75),
  "UGA": Pair(0.875, 0.75),
  "UKR": Pair(-1, 0.875),
  "UMI": Pair(-0.875, 0.875),
  "URS": Pair(-0.75, 0.875),
  "URU": Pair(-0.625, 0.875),
  "USA": Pair(-0.5, 0.875),
  "UZB": Pair(-0.375, 0.875),
  "VAN": Pair(-0.25, 0.875),
  "VAT": Pair(-0.125, 0.875),
  "VEN": Pair(0, 0.875),
  "VIE": Pair(0.125, 0.875),
  "VIN": Pair(0.25, 0.875),
  "WLF": Pair(0.375, 0.875),
  "YEM": Pair(0.5, 0.875),
  "YUG": Pair(0.625, 0.875),
  "ZAM": Pair(0.75, 0.875),
  "ZIM": Pair(0.875, 0.875),
};

class IocFlag extends StatelessWidget {
  final String ioc;
  final double? height;

  const IocFlag(this.ioc, {super.key, this.height});

  @override
  Widget build(BuildContext context) {
    Pair<double, double>? pos;
    if (findMap.containsKey(ioc)) {
      pos = findMap[ioc];
    } else {
      pos = Pair(1, 1);
    }
    final h = height ?? 30.0;
    return ClipRRect(
      borderRadius: BorderRadius.circular((h * 0.13).roundToDouble()), // 设置圆角半径
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Colors.grey), // 灰色描边
        ),
        child: SizedBox(
          height: h - 1,
          width: h * 4 / 3 - 1,
          child: Image.asset(
            iocFlags(h.toInt()),
            alignment: Alignment(pos!.first, pos.second),
            fit: BoxFit.none,
          ),
        ),
      ),
    );
  }
}

class Headshot extends StatelessWidget {
  final String pid;
  final double? height;
  final double? borderRadius;
  final BoxDecoration? decoration;

  const Headshot(this.pid,
      {super.key, this.height, this.borderRadius, this.decoration});

  @override
  Widget build(BuildContext context) {
    final h = height ?? 50;
    final r = borderRadius ?? 0;
    return ClipRRect(
        borderRadius: BorderRadius.circular(r),
        child: Container(
          height: h,
          width: h,
          decoration: decoration,
          child: Stack(children: [
            FutureBuilder(
              future: precacheImage(NetworkImage(playerHeadshot(pid)), context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return const SizedBox.shrink(); // 隐藏占位符
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            FadeInImage.memoryNetwork(
              image: playerHeadshot(pid),
              placeholder: kTransparentImage,
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 30),
            )
          ]),
        ));
  }
}

class Portrait extends StatelessWidget {
  final String pid;
  final double? height;
  final double? width;
  final BoxDecoration? decoration;

  const Portrait(this.pid,
      {super.key, this.height, this.width, this.decoration});

  @override
  Widget build(BuildContext context) {
    final h = height ?? 100;
    final w = width ?? h;
    return Container(
      height: h,
      width: w,
      decoration: decoration,
      child: Stack(children: [
        const Center(child: CircularProgressIndicator()),
        FadeInImage.memoryNetwork(
          image: playerPortrait(pid),
          placeholder: kTransparentImage,
          fit: BoxFit.fitHeight,
        )
      ]),
    );
  }
}
