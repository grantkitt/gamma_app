import 'package:gamma_v1/structs.dart';

hEvent neon = hEvent(
    'Neon Lights',
    DateTime.parse('2022-07-05 16:00:00'),
    '2400 Leon Street, Austin, Tx',
    '''Welcome to KSig's end of year shebang.
Bring some of your lovely lady charm
and we will bring the booze.

Starts at 4 sharp. 
See you then.
''',
    'assets/images/neonparty.jpg',
    'uuid',
    'howdypartner',
    'Kappa Sigma',
    'assets/images/ksig.jpg');
hEvent hippie = hEvent(
    'SIG CHI + HIPPIE',
    DateTime.parse('2022-08-05 12:00:00'),
    'Here',
    'Description ',
    'assets/images/hippie.jpg',
    'uuid',
    'howdypartner',
    'Sigma Chi TX',
    'assets/images/sigmachi.png');
hEvent semi = hEvent(
    'Sig Ep\'s semi-formal',
    DateTime.parse('2022-08-22 11:00:00'),
    'Here',
    'Description ',
    'assets/images/formal.jpg',
    'uuid',
    'howdypartner',
    'Texas Sig Ep',
    'assets/images/sigep.jpg');
hEvent texasind = hEvent(
    'Texas Independence',
    DateTime.parse('2022-07-29 19:00:00'),
    'Here',
    'Description ',
    'assets/images/texas.jpg',
    'uuid',
    'howdypartner',
    'TxPikes',
    'assets/images/pike.png');
hEvent holi = hEvent(
    'Longhorn Holi Festival',
    DateTime.parse('2022-08-01 20:00:00'),
    'Here',
    'Description ',
    'assets/images/holi.jpg',
    'uuid',
    'howdypartner',
    'Longhorn HSA',
    'assets/images/hsa.jpg');

List<hEvent> hevents = [neon, hippie, semi, texasind, holi];

hOrg ksig =
    hOrg('KappaSigma', 'austin, tx', 0.5, 'assets/images/ksig.jpg', '05093002');
hOrg hsa =
    hOrg('Longhorn HSA', 'austin, tx', 0.2, 'assets/icons/hsa.jpg', '29420y');

hUser hGrant = hUser(
    'gkitlow',
    'Grant',
    'grant.kitlowski@gmail.com',
    'Kitlowski',
    '5126219593',
    'assets/images/grant.jpg',
    DateTime.parse('2003-04-09'),
    'grant',
    [ksig, hsa]);
