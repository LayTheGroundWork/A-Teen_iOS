//
//  AppLocalized.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

public enum AppLocalized {
    public static let todaysTeen = "오늘의 인기 Teen"
    public static let aboutATeen = "About A-Teen"
    public static let runningTournament = "진행 중인 토너먼트"
    public static let anotherTeen = "또다른 Teen 살펴보기"
    
    public static let showMoreButton = "더보기"
    
    public static let startButton = "시작하기"
    public static let publicRelations = "자기 소개"
    public static let tenQuestions = "10문 10답"
    public static let voteButton = "투표하기"
    public static let loginButton = "로그인"
    public static let nextButton = "다음으로"
    public static let reportButton = "신고하기"
    public static let blockButton = "차단하기"
    public static let okButton = "알겠어요!"
    public static let okGoodButton = "좋아요!"
    public static let noButton = "아니요"
    public static let checkButton = "확인"
    public static let photo = "사진"
    public static let video = "동영상"
    
    // MARK: - AboutATeenTableViewCell
    public static let teenTitle = "Teen"
    public static let tournamentTitle = "토너먼트"
    public static let chatTitle = "채팅"
    public static let myTeenTitle = "나만의 Teen"
    
    public static let teenText = "친구들의 프로필을 투표해보세요!"
    public static let tournamentText = "투표 결과를 한 눈에 볼 수 있어요!"
    public static let chatText = "채팅을 통해 친구들과 소통해보세요!"
    public static let myTeenText = "나만의의 프로필을 등록해보세요!"
    
    // MARK: - LogInViewController
    public static let signupTitle = "가입하기"
    public static let signupSubTitle = """
                                프로필을 만들어 나의 사진을 자랑하고
                                TEEN에서 경쟁해보세요
                                """
    public static let signupPhoneNumberButton = "전화번호로 회원가입"
    public static let agreeTermsGuideTitle = """
                                    대한민국에서 위치한 계정으로 계속하면
                                    당사의 서비스 약관의 동의하고
                                    개인정보 처리방침을 읽었음을 인정하는 것입니다.
                                    """
    public static let uHaveAccountText = "이미 계정이 있으신가요?"
    public static let koreaText = "대한민국"
    public static let serviceTermsText = "서비스 약관"
    public static let userInfoPolicyText = "개인정보 처리방침"
    
    // MARK: - TermsOfUseViewController
    public static let usingTermsText = "사용 약관"
    public static let allAgreeText = "모두 동의"
    public static let serviceTermsAgreeText = "서비스 약관에 동의 (필수)"
    public static let userInfoAgreeText = "개인 정보 수집 및 사용에 동의 (필수)"
    public static let alarmAgreeText = "인기 콘텐츠 및 알림 수신 동의 (선택)"
    public static let alarmAgreeExplanationText = "A-TEEN에서 인기 콘텐츠 및 프로모션에 대한 알림을 받습니다. 언제든지 설정을 검토하고 편집할 수 있습니다. 동의를 하지 않아도 A-TEEN 서비스 사용이 제한되지 않습니다."
    public static let showDetailsButton = "세부 정보 보기"
    
    // MARK: - UserIdViewController
    public static let welcomeText = "반가워요! :)"
    public static let idInstructionText = "사용하실 아이디를 입력해주세요"
    public static let idCountText = "0/11"
    public static let idGuideText = "소문자 알파벳 또는 숫자 (4~11자리)\n아이디는 이후에 변경할 수 없습니다."
    
    // MARK: - UserNameViewController
    public static let secondWelcomeText = "A-TEEN에서 쓰일"
    public static let nameInstructionText = "이름 혹은 닉네임을 알려주세요"
    public static let nameCountText = "0/8"
    public static let nameGuideText = "특수문자를 제외한 한글/영어/숫자 (2~8자리)\n* 추후 언제든 수정 가능합니다."
    
    // MARK: - PhoneNumberCollectionViewCell
    public static let inputPhoneNumberText = "번호를 입력해주세요"
    public static let receiveCertificationCodeButton = "인증코드 받기"
    
    // MARK: - CertificationCodeCollectionViewCell
    public static let inputCodeText = "6자리 코드 입력"
    public static let resendText = "코드를 받지 못하셨나요? 다시 전송해보세요!"
    public static let resendButtonText = "다시 전송하기"
    
    // MARK: - Login / PhoneNumber / Dialogs
    public static let verificationCompleteDialogTitle = "인증이 완료되었어요!"
    public static let verificationCompleteDialogMessage = """
                                                A-TEEN에 정보를 입력하여
                                                가입을 마저 완료해보세요.
                                                """
    public static let existingUserDialogTitle = "이미 가입된 사용자에요!"
    public static let existingUserDialogMessage = "바로 로그인 할까요?"
    public static let invalidCodeNumberDialogTitle = "인증번호가 틀렸어요!"
    
    // MARK: - MainView / Report
    public static let reportDialogTitle = "신고 사유"
    public static let reportDialogViolenceReason = "폭력성 또는 선정적인 프로필"
    public static let reportDialogAdReason = "광고 게시물 또는 프로필"
    public static let reportDialogImpersonationReason = "타인을 사칭한 프로필"
    public static let reportDialogETCReason = "기타"
    public static let reportDialogPlaceholderText = "신고 사유를 작성해주세요."
    public static let reportDialogBlockButtonText = "해당 프로필 다시는 보지 않기"
    public static let reportDialogExplainText = "신고는 반대 의견을 표시하는 기능이 아닙니다."
    public static let reportCompleteDialogTitle = "신고가 완료되었습니다."
    
    // MARK: - Login / SignUp
    public static let userIDNumberOfCharactersErrrorMessage = "4자 이상 입력해주세요."
    public static let userIDLowercaseLetterOrNumberErrrorMessage = "영어 소문자 또는 숫자만 입력 해주세요."
    public static let userIDCount = "/11"
    public static let userNameNumberErrrorMessage = "2자 이상 입력해주세요."
    public static let userNameIncorrectKoreanErrorMessage = "한글을 바르게 입력해주세요."
    public static let userNameCount = "/8"
    public static let userBirthTitle = "당신의\n생년월일을 알려주세요!"
    public static let userBirthSelectButton = "태어난 날을 선택해주세요"
    public static let userBirthServiceTermsButton = "서비스 약관 바로 보기"
    public static let searchSchoolTitle = "다니고 있는\n학교를 알려주세요"
    public static let selectCategoryTitle = """
                                            TEEN에서 자랑할 나만의
                                            카테고리를 골라주세요!
                                            """
    public static let categoryMaximumText = "하나의 카테고리를 선택할 수 있어요!"
    // MARK: - Login / SelectPhoto
    public static let insertMediaText = "TEEN에서 자랑할\n사진이나 동영상을 추가해보세요"
    public static let maxInsertMediaCountText = "*최대 10개을 등록할 수 있어요"
    public static let photoGuideButton = "사진 가이드를 참고해주세요"
    
    // MARK: - MediaEditor
    public static let accessMediaText = "A - TEEN은 사용자가 선택한 사진만 엑세스할 수 있습니다."
    public static let selectPhotoCategoryText = "자랑할 사진의 카테고리를 선택해보세요!"
    public static let selectVideoCategoryText = "자랑할 영상의 카테고리를 선택해보세요!"
    public static let maxVideoTimeText = "영상의 길이는 최대 10초까지만 사용 가능해요"
    
    // MARK: - Celebrate
    public static let celebrateTitle = """
                                        등록이 완료되었어요!
                                        이제 A-TEEN을 시작해보세요 :)
                                        """
    
    // MARK: - Ranking
    public static let rankingTitleLabel = "Ranking"
    public static let rankingTextLabel = "투표해보세요"
    
    // MARK: - Teen / TeenDetail
    public static let teenTextLabel = "친구들의 프로필을\n구경해보세요!"
    public static let teenSubTitleLabel = "오늘의 TEEN"
    public static let teenDetailTextLabel = "투표 수가 많은 Teen"
}

// MARK: - Regex 모음
public enum ATeenRegex {
    public static let lowercaseOrNumber = "^[a-z0-9]+$"
    public static let lowercase = "^[a-z]"
    public static let lowercaseAndNumberFourToElevenCharacters = "^(?=.*[a-z])(?=.*[0-9]).{4,11}$"
    public static let characterAndNumber = "^[a-zA-Z0-9ㄱ-ㅎㅏ-ㅣ가-힣]"
    public static let completeKorean = "^[가-힣]*$"
    public static let incompleteKorean = "[ㄱ-ㅎㅏ-ㅣ]"
}
