class TarotCardData {
  final String id;
  final String name;
  final String imagePath;
  final bool isMajor;
  final String uprightDesc;
  final String reversedDesc;

  const TarotCardData({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.isMajor,
    required this.uprightDesc,
    required this.reversedDesc,
  });
}

const List<TarotCardData> tarotDeck = [
  // ---------------- 메이저 아르카나 (22장) ----------------
  TarotCardData(
    id: 'major_00', name: '0. 바보 (The Fool)', imagePath: 'assets/images/00-TheFool.jpg', isMajor: true,
    uprightDesc: '새로운 시작, 모험, 무한한 가능성, 자유, 순수함',
    reversedDesc: '무모함, 어리석음, 부주의, 너무 큰 위험을 감수함, 비현실성',
  ),
  TarotCardData(
    id: 'major_01', name: 'I. 마법사 (The Magician)', imagePath: 'assets/images/01-TheMagician.jpg', isMajor: true,
    uprightDesc: '창조력, 의지, 능력, 새로운 시작의 힘, 결단력',
    reversedDesc: '조작, 재능 낭비, 기만, 자신감 부족, 숨겨진 의도',
  ),
  TarotCardData(
    id: 'major_02', name: 'II. 고위 여사제 (The High Priestess)', imagePath: 'assets/images/02-TheHighPriestess.jpg', isMajor: true,
    uprightDesc: '직관, 무의식, 신비, 지혜, 내면의 목소리',
    reversedDesc: '직관 무시, 얕은 지식, 숨겨진 적, 비밀 누설',
  ),
  TarotCardData(
    id: 'major_03', name: 'III. 여황제 (The Empress)', imagePath: 'assets/images/03-TheEmpress.jpg', isMajor: true,
    uprightDesc: '풍요, 모성애, 아름다움, 자연의 결실, 창조성',
    reversedDesc: '과잉보호, 의존성, 창조적 결핍, 게으름, 정체기',
  ),
  TarotCardData(
    id: 'major_04', name: 'IV. 황제 (The Emperor)', imagePath: 'assets/images/04-TheEmperor.jpg', isMajor: true,
    uprightDesc: '권위, 구조, 안정, 부성애, 통제력, 책임감',
    reversedDesc: '독재, 지배욕, 융통성 부족, 무능함, 억압',
  ),
  TarotCardData(
    id: 'major_05', name: 'V. 교황 (The Hierophant)', imagePath: 'assets/images/05-TheHierophant.jpg', isMajor: true,
    uprightDesc: '전통, 믿음, 교육, 영적인 인도, 보수주의',
    reversedDesc: '반역, 관습 타파, 독단적 태도, 낡은 사상, 나쁜 조언',
  ),
  TarotCardData(
    id: 'major_06', name: 'VI. 연인 (The Lovers)', imagePath: 'assets/images/06-TheLovers.jpg', isMajor: true,
    uprightDesc: '사랑, 조화, 관계, 중요한 선택, 신뢰',
    reversedDesc: '불화, 잘못된 선택, 신뢰 상실, 유혹, 불균형',
  ),
  TarotCardData(
    id: 'major_07', name: 'VII. 전차 (The Chariot)', imagePath: 'assets/images/07-TheChariot.jpg', isMajor: true,
    uprightDesc: '의지, 승리, 결단력, 방향성, 성공을 향한 추진력',
    reversedDesc: '통제 상실, 방향 상실, 무기력, 공격성, 장애물',
  ),
  TarotCardData(
    id: 'major_08', name: 'VIII. 힘 (Strength)', imagePath: 'assets/images/08-Strength.jpg', isMajor: true,
    uprightDesc: '용기, 인내, 내면의 힘, 부드러운 통제, 자비',
    reversedDesc: '두려움, 나약함, 자기 통제력 상실, 충동, 자만심',
  ),
  TarotCardData(
    id: 'major_09', name: 'IX. 은둔자 (The Hermit)', imagePath: 'assets/images/09-TheHermit.jpg', isMajor: true,
    uprightDesc: '내면 탐구, 지혜, 고독, 깨달음, 영적 조언자',
    reversedDesc: '고립, 외로움, 현실 도피, 어리석은 고집, 은둔',
  ),
  TarotCardData(
    id: 'major_10', name: 'X. 운명의 수레바퀴 (Wheel of Fortune)', imagePath: 'assets/images/10-WheelOfFortune.jpg', isMajor: true,
    uprightDesc: '전환점, 운명, 행운, 끊임없는 변화, 기회',
    reversedDesc: '불운, 저항, 통제할 수 없는 변화, 불행의 반복',
  ),
  TarotCardData(
    id: 'major_11', name: 'XI. 정의 (Justice)', imagePath: 'assets/images/11-Justice.jpg', isMajor: true,
    uprightDesc: '공정함, 진실, 인과응보, 균형, 합리적 결정',
    reversedDesc: '불공평, 편견, 부정직, 피할 수 없는 처벌, 불균형',
  ),
  TarotCardData(
    id: 'major_12', name: 'XII. 매달린 사람 (The Hanged Man)', imagePath: 'assets/images/12-TheHangedMan.jpg', isMajor: true,
    uprightDesc: '희생, 새로운 시각, 기다림, 통찰, 일시적 정지',
    reversedDesc: '무의미한 희생, 지연, 발전을 거부함, 이기주의',
  ),
  TarotCardData(
    id: 'major_13', name: 'XIII. 죽음 (Death)', imagePath: 'assets/images/13-Death.jpg', isMajor: true,
    uprightDesc: '끝과 새로운 시작, 변화, 전환기, 과거 청산',
    reversedDesc: '변화에 대한 저항, 정체, 낡은 것에 집착, 두려움',
  ),
  TarotCardData(
    id: 'major_14', name: 'XIV. 절제 (Temperance)', imagePath: 'assets/images/14-Temperance.jpg', isMajor: true,
    uprightDesc: '조화, 균형, 중용, 치유, 목적 의식',
    reversedDesc: '불균형, 무절제, 극단적인 행동, 부조화, 갈등',
  ),
  TarotCardData(
    id: 'major_15', name: 'XV. 악마 (The Devil)', imagePath: 'assets/images/15-TheDevil.jpg', isMajor: true,
    uprightDesc: '집착, 물질주의, 속박, 유혹, 파괴적 욕망',
    reversedDesc: '해방, 속박에서 벗어남, 독립, 깨달음, 자유',
  ),
  TarotCardData(
    id: 'major_16', name: 'XVI. 탑 (The Tower)', imagePath: 'assets/images/16-TheTower.jpg', isMajor: true,
    uprightDesc: '갑작스러운 변화, 파괴, 해방, 계시, 붕괴',
    reversedDesc: '재난의 회피, 피할 수 없는 변화의 지연, 경고 무시',
  ),
  TarotCardData(
    id: 'major_17', name: 'XVII. 별 (The Star)', imagePath: 'assets/images/17-TheStar.jpg', isMajor: true,
    uprightDesc: '희망, 영감, 평온, 치유와 긍정, 영적 인도',
    reversedDesc: '절망, 실망, 영감 부족, 비관주의, 혼란',
  ),
  TarotCardData(
    id: 'major_18', name: 'XVIII. 달 (The Moon)', imagePath: 'assets/images/18-TheMoon.jpg', isMajor: true,
    uprightDesc: '불안, 환상, 직관, 숨겨진 진실, 기만',
    reversedDesc: '두려움의 극복, 비밀의 발견, 불안 해소, 진실 규명',
  ),
  TarotCardData(
    id: 'major_19', name: 'XIX. 태양 (The Sun)', imagePath: 'assets/images/19-TheSun.jpg', isMajor: true,
    uprightDesc: '성공, 긍정, 활력, 행복과 성취, 기쁨',
    reversedDesc: '지연된 성공, 과장, 활력 저하, 슬픔의 이면',
  ),
  TarotCardData(
    id: 'major_20', name: 'XX. 심판 (Judgement)', imagePath: 'assets/images/20-Judgement.jpg', isMajor: true,
    uprightDesc: '부활, 결단, 용서, 새로운 소명, 내적 각성',
    reversedDesc: '후회, 자기 의심, 변화에 대한 두려움, 미련, 형벌',
  ),
  TarotCardData(
    id: 'major_21', name: 'XXI. 세계 (The World)', imagePath: 'assets/images/21-TheWorld.jpg', isMajor: true,
    uprightDesc: '완성, 성취, 통합, 새로운 차원, 성공적인 마무리',
    reversedDesc: '미완성, 연기, 정체, 성공에 대한 두려움, 지연',
  ),

  // ---------------- 마이너 아르카나 - 컵 (14장) ----------------
  TarotCardData(
    id: 'cups_01', name: '컵의 에이스 (Ace of Cups)', imagePath: 'assets/images/Cups01.jpg', isMajor: false,
    uprightDesc: '새로운 감정, 사랑의 시작, 직관, 영적 충만함',
    reversedDesc: '감정의 차단, 사랑받지 못함, 공허함, 슬픔',
  ),
  TarotCardData(
    id: 'cups_02', name: '컵 2 (Two of Cups)', imagePath: 'assets/images/Cups02.jpg', isMajor: false,
    uprightDesc: '관계의 조화, 결합, 사랑, 상호 존중, 협력',
    reversedDesc: '관계의 불화, 이별, 오해, 불균형, 짝사랑',
  ),
  TarotCardData(
    id: 'cups_03', name: '컵 3 (Three of Cups)', imagePath: 'assets/images/Cups03.jpg', isMajor: false,
    uprightDesc: '축하, 우정, 공동체, 기쁨, 창조적 결실',
    reversedDesc: '과음, 소외, 파벌, 삼각관계, 축제의 취소',
  ),
  TarotCardData(
    id: 'cups_04', name: '컵 4 (Four of Cups)', imagePath: 'assets/images/Cups04.jpg', isMajor: false,
    uprightDesc: '무관심, 권태, 명상, 놓쳐버린 기회, 내면 성찰',
    reversedDesc: '새로운 인식, 기회를 잡음, 활력 회복, 각성',
  ),
  TarotCardData(
    id: 'cups_05', name: '컵 5 (Five of Cups)', imagePath: 'assets/images/Cups05.jpg', isMajor: false,
    uprightDesc: '상실, 슬픔, 과거에 대한 후회, 비관주의',
    reversedDesc: '상실의 극복, 수용, 치유, 새로운 희망의 발견',
  ),
  TarotCardData(
    id: 'cups_06', name: '컵 6 (Six of Cups)', imagePath: 'assets/images/Cups06.jpg', isMajor: false,
    uprightDesc: '과거의 향수, 어린 시절, 순수함, 옛 친구, 추억',
    reversedDesc: '과거에 얽매임, 미래를 외면함, 독립, 성장',
  ),
  TarotCardData(
    id: 'cups_07', name: '컵 7 (Seven of Cups)', imagePath: 'assets/images/Cups07.jpg', isMajor: false,
    uprightDesc: '환상, 꿈, 선택의 혼란, 현실 도피, 백일몽',
    reversedDesc: '현실 직시, 명확한 목표, 환상에서 깨어남, 결단',
  ),
  TarotCardData(
    id: 'cups_08', name: '컵 8 (Eight of Cups)', imagePath: 'assets/images/Cups08.jpg', isMajor: false,
    uprightDesc: '실망, 떠남, 더 깊은 의미를 찾기 위한 포기, 체념',
    reversedDesc: '떠나지 못함, 과거에 집착, 관계 회복, 두려움',
  ),
  TarotCardData(
    id: 'cups_09', name: '컵 9 (Nine of Cups)', imagePath: 'assets/images/Cups09.jpg', isMajor: false,
    uprightDesc: '소원 성취, 만족감, 감각적 기쁨, 자부심, 행복',
    reversedDesc: '불만족, 허영심, 표면적인 성공, 욕심, 탐욕',
  ),
  TarotCardData(
    id: 'cups_10', name: '컵 10 (Ten of Cups)', imagePath: 'assets/images/Cups10.jpg', isMajor: false,
    uprightDesc: '가족의 행복, 평화, 정서적 충만, 조화로운 관계',
    reversedDesc: '가족 내 갈등, 깨진 가정, 불화, 평화 상실',
  ),
  TarotCardData(
    id: 'cups_11', name: '컵의 시종 (Page of Cups)', imagePath: 'assets/images/Cups11.jpg', isMajor: false,
    uprightDesc: '새로운 영감, 창의성, 감성적인 메시지, 직관력',
    reversedDesc: '감정적 미성숙, 창의적 차단, 나쁜 소식, 예민함',
  ),
  TarotCardData(
    id: 'cups_12', name: '컵의 기사 (Knight of Cups)', imagePath: 'assets/images/Cups12.jpg', isMajor: false,
    uprightDesc: '로맨스, 매력, 감정적 접근, 상상력, 기사도',
    reversedDesc: '비현실성, 변덕, 질투, 신뢰할 수 없음, 기만',
  ),
  TarotCardData(
    id: 'cups_13', name: '컵의 여왕 (Queen of Cups)', imagePath: 'assets/images/Cups13.jpg', isMajor: false,
    uprightDesc: '공감, 다정함, 영적 직관, 감성적 안정, 배려',
    reversedDesc: '감정 과잉, 불안정, 의존적 성향, 희생자 코스프레',
  ),
  TarotCardData(
    id: 'cups_14', name: '컵의 왕 (King of Cups)', imagePath: 'assets/images/Cups14.jpg', isMajor: false,
    uprightDesc: '감정적 통제, 균형, 외교, 관용, 지혜로운 조언',
    reversedDesc: '감정적 조작, 냉담함, 불안정성, 기분파, 무자비',
  ),

  // ---------------- 마이너 아르카나 - 펜타클 (14장) ----------------
  TarotCardData(
    id: 'pentacles_01', name: '펜타클 에이스 (Ace of Pentacles)', imagePath: 'assets/images/Pentacles01.jpg', isMajor: false,
    uprightDesc: '새로운 기회, 재정적 시작, 풍요, 현실적 성취',
    reversedDesc: '잃어버린 기회, 재정적 손실, 지연, 나쁜 투자',
  ),
  TarotCardData(
    id: 'pentacles_02', name: '펜타클 2 (Two of Pentacles)', imagePath: 'assets/images/Pentacles02.jpg', isMajor: false,
    uprightDesc: '균형, 적응력, 시간/재정 관리, 유연성',
    reversedDesc: '불균형, 감당하기 벅참, 재정적 어려움, 스트레스',
  ),
  TarotCardData(
    id: 'pentacles_03', name: '펜타클 3 (Three of Pentacles)', imagePath: 'assets/images/Pentacles03.jpg', isMajor: false,
    uprightDesc: '팀워크, 협업, 기술, 인정받는 노력, 건축',
    reversedDesc: '협업 부족, 기술 부족, 인정받지 못함, 의견 충돌',
  ),
  TarotCardData(
    id: 'pentacles_04', name: '펜타클 4 (Four of Pentacles)', imagePath: 'assets/images/Pentacles04.jpg', isMajor: false,
    uprightDesc: '안정, 소유욕, 보수성, 인색함, 축적',
    reversedDesc: '탐욕의 대가, 손실, 재정 방만, 집착을 버림',
  ),
  TarotCardData(
    id: 'pentacles_05', name: '펜타클 5 (Five of Pentacles)', imagePath: 'assets/images/Pentacles05.jpg', isMajor: false,
    uprightDesc: '궁핍, 재정적/정서적 결핍, 소외, 역경',
    reversedDesc: '재정 회복, 도움의 손길, 역경 극복, 긍정적 변화',
  ),
  TarotCardData(
    id: 'pentacles_06', name: '펜타클 6 (Six of Pentacles)', imagePath: 'assets/images/Pentacles06.jpg', isMajor: false,
    uprightDesc: '자선, 나눔, 후원, 공정함, 베풂과 받음',
    reversedDesc: '이기심, 채무, 불평등, 생색내기, 착취',
  ),
  TarotCardData(
    id: 'pentacles_07', name: '펜타클 7 (Seven of Pentacles)', imagePath: 'assets/images/Pentacles07.jpg', isMajor: false,
    uprightDesc: '인내, 장기적 비전, 노력에 대한 보상 기다림, 평가',
    reversedDesc: '조바심, 성과 없는 노력, 지연, 좌절, 투자 실패',
  ),
  TarotCardData(
    id: 'pentacles_08', name: '펜타클 8 (Eight of Pentacles)', imagePath: 'assets/images/Pentacles08.jpg', isMajor: false,
    uprightDesc: '장인 정신, 전념, 세부사항에 대한 주의, 숙련',
    reversedDesc: '지루함, 완벽주의의 함정, 나태, 열정 상실',
  ),
  TarotCardData(
    id: 'pentacles_09', name: '펜타클 9 (Nine of Pentacles)', imagePath: 'assets/images/Pentacles09.jpg', isMajor: false,
    uprightDesc: '성취, 독립, 여유, 재정적 안락함, 자기 보상',
    reversedDesc: '과소비, 겉보기에만 화려함, 의존성, 재정 불안',
  ),
  TarotCardData(
    id: 'pentacles_10', name: '펜타클 10 (Ten of Pentacles)', imagePath: 'assets/images/Pentacles10.jpg', isMajor: false,
    uprightDesc: '가업, 부의 축적, 유산, 안정된 삶, 전통',
    reversedDesc: '재산 손실, 가족 분쟁, 전통에 대한 반항, 불안정',
  ),
  TarotCardData(
    id: 'pentacles_11', name: '펜타클 시종 (Page of Pentacles)', imagePath: 'assets/images/Pentacles11.jpg', isMajor: false,
    uprightDesc: '현실적인 목표, 새로운 공부, 기회, 실용성, 계획',
    reversedDesc: '계획의 지연, 실용성 부족, 게으름, 미루는 습관',
  ),
  TarotCardData(
    id: 'pentacles_12', name: '펜타클 기사 (Knight of Pentacles)', imagePath: 'assets/images/Pentacles12.jpg', isMajor: false,
    uprightDesc: '성실, 책임감, 끈기, 점진적인 발전, 믿음직함',
    reversedDesc: '완고함, 무기력, 일 중독, 유연성 부족, 정체',
  ),
  TarotCardData(
    id: 'pentacles_13', name: '펜타클 여왕 (Queen of Pentacles)', imagePath: 'assets/images/Pentacles13.jpg', isMajor: false,
    uprightDesc: '현실적 보살핌, 실용적 조언, 풍요, 관대함, 안락함',
    reversedDesc: '과잉 통제, 소유욕, 이기심, 재정적 불안, 과소비',
  ),
  TarotCardData(
    id: 'pentacles_14', name: '펜타클 왕 (King of Pentacles)', imagePath: 'assets/images/Pentacles14.jpg', isMajor: false,
    uprightDesc: '부와 성공, 비즈니스 수완, 권위, 든든한 후원자',
    reversedDesc: '물질주의, 부패, 탐욕, 고집불통, 억압적 권위',
  ),

  // ---------------- 마이너 아르카나 - 소드 (14장) ----------------
  TarotCardData(
    id: 'swords_01', name: '소드 에이스 (Ace of Swords)', imagePath: 'assets/images/Swords01.jpg', isMajor: false,
    uprightDesc: '명확한 통찰, 새로운 생각, 진실, 정신적 돌파구',
    reversedDesc: '혼란, 잘못된 정보, 판단력 상실, 소통 부재',
  ),
  TarotCardData(
    id: 'swords_02', name: '소드 2 (Two of Swords)', imagePath: 'assets/images/Swords02.jpg', isMajor: false,
    uprightDesc: '우유부단, 맹목, 감정 차단, 어려운 결정의 회피',
    reversedDesc: '결단, 사실을 직시함, 정보 부족으로 인한 실수',
  ),
  TarotCardData(
    id: 'swords_03', name: '소드 3 (Three of Swords)', imagePath: 'assets/images/Swords03.jpg', isMajor: false,
    uprightDesc: '상심, 슬픔, 이별, 상처, 고통스러운 진실',
    reversedDesc: '고통의 극복, 치유, 용서, 슬픔을 떨쳐냄',
  ),
  TarotCardData(
    id: 'swords_04', name: '소드 4 (Four of Swords)', imagePath: 'assets/images/Swords04.jpg', isMajor: false,
    uprightDesc: '휴식, 회복, 명상, 스트레스 완화, 내면의 평화',
    reversedDesc: '탈진, 회복 거부, 강제 휴식, 극심한 스트레스',
  ),
  TarotCardData(
    id: 'swords_05', name: '소드 5 (Five of Swords)', imagePath: 'assets/images/Swords05.jpg', isMajor: false,
    uprightDesc: '상처뿐인 승리, 배신, 갈등, 적의감, 비열함',
    reversedDesc: '갈등 해결, 화해, 타협, 패배 인정, 복수 포기',
  ),
  TarotCardData(
    id: 'swords_06', name: '소드 6 (Six of Swords)', imagePath: 'assets/images/Swords06.jpg', isMajor: false,
    uprightDesc: '전환, 고통에서 벗어남, 치유의 여정, 이동, 여행',
    reversedDesc: '변화에 대한 저항, 과거의 상처가 발목을 잡음, 지연',
  ),
  TarotCardData(
    id: 'swords_07', name: '소드 7 (Seven of Swords)', imagePath: 'assets/images/Swords07.jpg', isMajor: false,
    uprightDesc: '기만, 속임수, 전략, 은밀한 행동, 도주',
    reversedDesc: '자백, 비밀 폭로, 속임수 발각, 죄책감, 정면 돌파',
  ),
  TarotCardData(
    id: 'swords_08', name: '소드 8 (Eight of Swords)', imagePath: 'assets/images/Swords08.jpg', isMajor: false,
    uprightDesc: '자승자박, 무기력, 제한된 생각, 두려움의 감옥',
    reversedDesc: '해방, 스스로의 감옥에서 벗어남, 새로운 관점',
  ),
  TarotCardData(
    id: 'swords_09', name: '소드 9 (Nine of Swords)', imagePath: 'assets/images/Swords09.jpg', isMajor: false,
    uprightDesc: '불안, 절망, 불면증, 죄책감, 내면의 공포',
    reversedDesc: '공포 극복, 희망의 빛, 불면증 해소, 사실 직시',
  ),
  TarotCardData(
    id: 'swords_10', name: '소드 10 (Ten of Swords)', imagePath: 'assets/images/Swords10.jpg', isMajor: false,
    uprightDesc: '파멸, 깊은 상처, 배신, 바닥을 침, 끝의 도래',
    reversedDesc: '파멸에서의 회복, 최악은 지났음, 생존, 재건',
  ),
  TarotCardData(
    id: 'swords_11', name: '소드 시종 (Page of Swords)', imagePath: 'assets/images/Swords11.jpg', isMajor: false,
    uprightDesc: '호기심, 예리한 분석력, 진실 탐구, 새로운 아이디어',
    reversedDesc: '경솔함, 조급함, 냉소주의, 근거 없는 소문, 무례',
  ),
  TarotCardData(
    id: 'swords_12', name: '소드 기사 (Knight of Swords)', imagePath: 'assets/images/Swords12.jpg', isMajor: false,
    uprightDesc: '돌진, 야망, 지적 추진력, 빠르고 단호한 행동',
    reversedDesc: '무모함, 공격성, 배려 없는 언행, 충동성, 무자비',
  ),
  TarotCardData(
    id: 'swords_13', name: '소드 여왕 (Queen of Swords)', imagePath: 'assets/images/Swords13.jpg', isMajor: false,
    uprightDesc: '독립, 명확한 의사소통, 예리한 판단, 정직함, 객관성',
    reversedDesc: '비정함, 냉혹함, 과도한 비판, 원한, 고립',
  ),
  TarotCardData(
    id: 'swords_14', name: '소드 왕 (King of Swords)', imagePath: 'assets/images/Swords14.jpg', isMajor: false,
    uprightDesc: '권위, 지적 통찰, 논리, 공정함, 원칙, 전문가',
    reversedDesc: '권력 남용, 비합리성, 잔인함, 통제욕, 독재',
  ),

  // ---------------- 마이너 아르카나 - 완드 (14장) ----------------
  TarotCardData(
    id: 'wands_01', name: '완드 에이스 (Ace of Wands)', imagePath: 'assets/images/Wands01.jpg', isMajor: false,
    uprightDesc: '열정, 영감, 창조적 힘, 새로운 잠재력, 활력',
    reversedDesc: '열정의 지연, 영감 부족, 의욕 상실, 정체성 혼란',
  ),
  TarotCardData(
    id: 'wands_02', name: '완드 2 (Two of Wands)', imagePath: 'assets/images/Wands02.jpg', isMajor: false,
    uprightDesc: '계획, 비전, 장기적 목표, 결단력, 탐험',
    reversedDesc: '계획 부족, 미루기, 두려움에 의한 정체, 제한된 비전',
  ),
  TarotCardData(
    id: 'wands_03', name: '완드 3 (Three of Wands)', imagePath: 'assets/images/Wands03.jpg', isMajor: false,
    uprightDesc: '기대의 실현, 진전, 확장, 선견지명, 리더십',
    reversedDesc: '성장의 지연, 좌절, 예상치 못한 장애, 편협함',
  ),
  TarotCardData(
    id: 'wands_04', name: '완드 4 (Four of Wands)', imagePath: 'assets/images/Wands04.jpg', isMajor: false,
    uprightDesc: '축하, 안락함, 성취의 기쁨, 환영, 집안의 행사',
    reversedDesc: '취소된 행사, 가정의 불화, 일시적 안정, 지연된 축하',
  ),
  TarotCardData(
    id: 'wands_05', name: '완드 5 (Five of Wands)', imagePath: 'assets/images/Wands05.jpg', isMajor: false,
    uprightDesc: '경쟁, 갈등, 의견 대립, 다툼, 도전',
    reversedDesc: '타협, 갈등의 회피, 협력, 평화 추구, 혼란 진정',
  ),
  TarotCardData(
    id: 'wands_06', name: '완드 6 (Six of Wands)', imagePath: 'assets/images/Wands06.jpg', isMajor: false,
    uprightDesc: '성공, 대중의 인정, 승리, 자신감, 리더의 부상',
    reversedDesc: '패배, 불명예, 인정받지 못함, 교만, 명성 추락',
  ),
  TarotCardData(
    id: 'wands_07', name: '완드 7 (Seven of Wands)', imagePath: 'assets/images/Wands07.jpg', isMajor: false,
    uprightDesc: '용기, 방어, 경쟁에 맞섬, 확고한 신념, 인내',
    reversedDesc: '포기, 압도됨, 타협, 자신감 상실, 비겁함',
  ),
  TarotCardData(
    id: 'wands_08', name: '완드 8 (Eight of Wands)', imagePath: 'assets/images/Wands08.jpg', isMajor: false,
    uprightDesc: '신속한 진행, 빠른 결말, 소식, 민첩함, 속도',
    reversedDesc: '지연, 혼란, 서두름으로 인한 실수, 소통 불능',
  ),
  TarotCardData(
    id: 'wands_09', name: '완드 9 (Nine of Wands)', imagePath: 'assets/images/Wands09.jpg', isMajor: false,
    uprightDesc: '회복력, 방어 태세, 지쳐도 계속함, 경계, 체력 시험',
    reversedDesc: '피로, 편집증, 포기, 완고함, 불필요한 저항',
  ),
  TarotCardData(
    id: 'wands_10', name: '완드 10 (Ten of Wands)', imagePath: 'assets/images/Wands10.jpg', isMajor: false,
    uprightDesc: '과도한 짐, 극심한 부담, 책임감, 압박, 한계점',
    reversedDesc: '짐을 내려놓음, 책임 회피, 탈진, 위임, 극복',
  ),
  TarotCardData(
    id: 'wands_11', name: '완드 시종 (Page of Wands)', imagePath: 'assets/images/Wands11.jpg', isMajor: false,
    uprightDesc: '탐험, 발견, 열정적인 아이디어, 에너지, 매력',
    reversedDesc: '방향 상실, 미숙함, 쉽게 싫증냄, 헛된 망상, 무책임',
  ),
  TarotCardData(
    id: 'wands_12', name: '완드 기사 (Knight of Wands)', imagePath: 'assets/images/Wands12.jpg', isMajor: false,
    uprightDesc: '열정적 전진, 모험심, 행동력, 에너지, 자신감',
    reversedDesc: '충동적 행동, 오만함, 변덕, 분노, 무계획',
  ),
  TarotCardData(
    id: 'wands_13', name: '완드 여왕 (Queen of Wands)', imagePath: 'assets/images/Wands13.jpg', isMajor: false,
    uprightDesc: '카리스마, 용기, 독립, 밝음, 매력, 활기',
    reversedDesc: '이기심, 과시욕, 질투, 변덕스러움, 공격성',
  ),
  TarotCardData(
    id: 'wands_14', name: '완드 왕 (King of Wands)', imagePath: 'assets/images/Wands14.jpg', isMajor: false,
    uprightDesc: '카리스마적 리더십, 비전, 영감, 대담함, 기업가',
    reversedDesc: '독재, 충동적 분노, 비현실성, 오만, 가차없음',
  ),
];
