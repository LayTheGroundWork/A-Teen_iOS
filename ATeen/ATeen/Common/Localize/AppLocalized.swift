//
//  AppLocalized.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

enum AppLocalized {
    static let todaysTeen = "오늘의 인기 Teen"
    static let aboutATeen = "About A-Teen"
    static let runningTournament = "진행 중인 토너먼트"
    static let anotherTeen = "또다른 Teen 살펴보기"
    
    static let showMoreButton = "더보기"
    
    static let publicRelations = "자기 소개"
    static let tenQuestions = "10문 10답"
    static let voteButton = "투표하기"
    static let loginButton = "로그인"
    static let nextButton = "다음으로"
    static let reportButton = "신고하기"
    static let blockButton = "차단하기"
    static let okButton = "알겠어요!"
    static let okGoodButton = "좋아요!"
    static let noButton = "아니요"
    static let checkButton = "확인"
    
    // MARK: - AboutATeenTableViewCell
    static let teenTitle = "Teen"
    static let tournamentTitle = "토너먼트"
    static let chatTitle = "채팅"
    static let myTeenTitle = "나만의 Teen"
    
    static let teenText = "친구들의 프로필을 투표해보세요!"
    static let tournamentText = "투표 결과를 한 눈에 볼 수 있어요!"
    static let chatText = "채팅을 통해 친구들과 소통해보세요!"
    static let myTeenText = "나만의의 프로필을 등록해보세요!"
    
    // MARK: - LogInViewController
    static let signupTitle = "가입하기"
    static let signupSubTitle = """
                                프로필을 만들어 나의 사진을 자랑하고
                                TEEN에서 경쟁해보세요
                                """
    static let signupPhoneNumberButton = "전화번호로 회원가입"
    static let agreeTermsGuideTitle = """
                                    대한민국에서 위치한 계정으로 계속하면
                                    당사의 서비스 약관의 동의하고
                                    개인정보 처리방침을 읽었음을 인정하는 것입니다.
                                    """
    static let uHaveAccountText = "이미 계정이 있으신가요?"
    static let koreaText = "대한민국"
    static let serviceTermsText = "서비스 약관"
    static let userInfoPolicyText = "개인정보 처리방침"
    
    // MARK: - TermsOfUseViewController
    static let usingTermsText = "사용 약관"
    static let allAgreeText = "모두 동의"
    static let serviceTermsAgreeText = "서비스 약관에 동의 (필수)"
    static let userInfoAgreeText = "개인 정보 수집 및 사용에 동의 (필수)"
    static let alarmAgreeText = "인기 콘텐츠 및 알림 수신 동의 (선택)"
    static let alarmAgreeExplanationText = "A-TEEN에서 인기 콘텐츠 및 프로모션에 대한 알림을 받습니다. 언제든지 설정을 검토하고 편집할 수 있습니다. 동의를 하지 않아도 A-TEEN 서비스 사용이 제한되지 않습니다."
    static let showDetailsButton = "세부 정보 보기"
    
    // MARK: - UserIdViewController
    static let welcomeText = "반가워요! :)"
    static let idInstructionText = "사용하실 아이디를 입력해주세요"
    static let idCountText = "0/11"
    static let idGuideText = "소문자 알파벳 + 숫자 (4~11자리)\n아이디는 이후에 변경할 수 없습니다."
    
    // MARK: - UserNameViewController
    static let secondWelcomeText = "A-TEEN에서 쓰일"
    static let nameInstructionText = "이름 혹은 닉네임을 알려주세요"
    static let nameCountText = "0/8"
    static let nameGuideText = "특수문자를 제외한 한글/영어/숫자 (2~8자리)\n* 추후 언제든 수정 가능합니다."
    
    // MARK: - PhoneNumberCollectionViewCell
    static let inputPhoneNumberText = "번호를 입력해주세요"
    static let receiveCertificationCodeButton = "인증코드 받기"
    
    // MARK: - CertificationCodeCollectionViewCell
    static let inputCodeText = "6자리 코드 입력"
    static let resendText = "코드를 받지 못하셨나요? 다시 전송해보세요!"
    static let resendButtonText = "다시 전송하기"
    
    // MARK: - Login / PhoneNumber / Dialogs
    static let verificationCompleteDialogTitle = "인증이 완료되었어요!"
    static let verificationCompleteDialogMessage = """
                                                A-TEEN에 정보를 입력하여
                                                가입을 마저 완료해보세요.
                                                """
    static let existingUserDialogTitle = "이미 가입된 사용자에요!"
    static let existingUserDialogMessage = "바로 로그인 할까요?"

    // MARK: - MainView / Report
    static let reportDialogTitle = "신고 사유"
    static let reportDialogViolenceReason = "폭력성 또는 선정적인 프로필"
    static let reportDialogAdReason = "광고 게시물 또는 프로필"
    static let reportDialogImpersonationReason = "타인을 사칭한 프로필"
    static let reportDialogETCReason = "기타"
    static let reportDialogPlaceholderText = "신고 사유를 작성해주세요."
    static let reportDialogBlockButtonText = "해당 프로필 다시는 보지 않기"
    static let reportDialogExplainText = "신고는 반대 의견을 표시하는 기능이 아닙니다."
    static let reportCompleteDialogTitle = "신고가 완료되었습니다."
    
    // MARK: - Login / SignUp
    static let userIDNumberOfCharactersErrrorMessage = "4자 이상 입력해주세요."
    static let userIDNumberErrrorMessage = "숫자를 추가해주세요."
    static let userIDLowercaseLetterErrrorMessage = "영어 소문자를 추가해주세요."
    static let userIDCount = "/11"
    static let userNameNumberErrrorMessage = "2자 이상 입력해주세요."
    static let userNameIncorrectKoreanErrorMessage = "한글을 바르게 입력해주세요."
    static let userNameCount = "/8"
    static let userBirthTitle = "당신의\n생년월일을 알려주세요!"
    static let userBirthSelectButton = "태어난 날을 선택해주세요"
    static let userBirthServiceTermsButton = "서비스 약관 바로 보기"
    static let searchSchoolTitle = "다니고 있는\n학교를 알려주세요"

}

// MARK: - Regex 모음
enum ATeenRegex {
    static let lowercaseAndNumber = "^[a-z0-9]"
    static let lowercase = "^[a-z]"
    static let lowercaseAndNumberFourToElevenCharacters = "^(?=.*[a-z])(?=.*[0-9]).{4,11}$"
    static let characterAndNumber = "^[a-zA-Z0-9ㄱ-ㅎㅏ-ㅣ가-힣]"
    static let completeKorean = "^[가-힣]*$"
    static let incompleteKorean = "[ㄱ-ㅎㅏ-ㅣ]"
}
