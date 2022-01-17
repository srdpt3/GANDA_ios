//
//  Constants.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/2/22.
//

import SwiftUI
import Firebase
import FirebaseStorage


let screen = UIScreen.main.bounds
let APP_LOGO = "logo_main"
let APP_LOGO_SMALL = "logo"
let APP_NAME = "GANDA"
let NAME_ = "앱이름"



// Information
let APP_VERSION = "1.0.0"
let APP_DESC = "패션 스타일 통해 사람들과 소통할 수 있는 공간. 오늘 내 옷 스타일 어때? \n\n자유롭게 나만의 스타일을 표현하고 사람들의 투표를 받아보세요. 또 사람들의 옷 스타일에 투표를 하고, 최신 옷 트렌드도 파악해보세요 \n\n* 오늘 평가받고 싶은 나의 옷 사진을 채널에 게시해보세요. 사람들이 당신의 옷 스타일에 투표할겁니다. \n\n* 다른 사람의 옷 스타일에 투표해보세요. \nGood or Bad?"

let APP_CREDIT = "크레딧"

let APP_PLATFORM = "플랫폼"
let COMPANY = "회사"
let HOMEPAGE = "홈페이지"
let TWITTER_PAGE = "인스타그램"

let VERSION = "앱버젼"
let MIN_REQUIREMENT = "iPhone X 기종 이상 - iOS 15 이상"
let COMPANY_NAME = ""
let COMPANY_HOMEPAGE = "FrontYardTech.com"
let DEVELOPER = "개발자"
let CEO = "대표"



let COLOR_LIGHT_GRAY = Color(red: 0, green: 0, blue: 0, opacity: 0.15)
let APP_THEME_COLOR = Color("Blue")
let APP_BACKGROUND = Color("BG")


let INITIAL_POINT = 2000
let POINT_USE = 10
let DEFAULT_LOCATION = "대한민국"
//public let BANNER_UNIT_ID = "ca-app-pub-1790336833303238/5428347738"

//TEST BANNER UNIT ID
public let BANNER_UNIT_ID = "ca-app-pub-3940256099942544/2934735716"
//public let BANNER_UNIT_ID = "ca-app-pub-1790336833303238~5310295210"

//
//GADApplicationIdentifier : ca-app-pub-1790336833303238~5310295210
//TEST  GADApplicationIdentifier : ca-app-pub-1790336833303238~5310295210


// Tabbar
public let index1 = "카드"
public let index3 = "내 첫인상"
public let index2 = "호감"
public let index4 = "채팅"
public let TABBAR_FONT_SIZE = 13


public var BELL = "bell"
public var FONT = "JSDongkang-Regular"
public var FONT_BOLD = "JSDongkang-Bold"
public var FONT_COOKIE = "CookieRun Regular"



public let BUTTON_TITLE_FONT_SIZE = 18

//public var FONT = "CookieRun Regular"

public let VOTE_NUMBER = "numVote"
public let CHART_Y_AXIS = 100
public let CARD_LIMIT_TO_QUERY = 36
public let MY_CARD_LIMIT_TO_QUERY = 20





public let CONFIRM =  "확인"
public let CANCEL =  "취소"
public let ERROR =  "에러"
public let COMPLETE =  "완료"
public let CONTINUE =  "계속"


// Sign in and Sign up pages
let TEXT_NEED_AN_ACCOUNT = "계정이 없으신가요?"
let TEXT_SIGN_UP = "새로 가입하기"
let TEXT_SIGN_IN = "로그인 하기"
let TEXT_EMAIL = "이메일"
let TEXT_USERNAME = "닉네임"
let TEXT_PASSWORD = "비밀번호"
let TEXT_PASSWORD_REENTER = "비밀번호 다시입력"
let AGE = "나이대 선택 "



let TEXT_SIGNUP_NOTE = "An account will allow you to save and access photo information across devices. You can delete your account at any time and your information will not be shared."
let TEXT_SIGNUP_PASSWORD_REQUIRED = "최소 8자리 비밀번호를 입력해주세요"
let TERM_AGREEMENT = "I Read And Agree The Terms And Conditions"
let TERM_AGREEMENT2 = "약관에 동의합니다"
let PROFILE_UPLOAD = "프로필사진을 등록해주세요 "
let MiMATCH_PASSWORD = "비밀번호가 일치하지 않습니다"
let PASSWORD_MINIMUM_LENGTH_ERROR = "비밀번호를 8자 이상 입력해주세요"
let ALREADY_EXIST_EMAIL = "이미 사용 중인 계정입니다. \n다시 입력해주세요"

let TAG_LIMIT_ERROR = "태그 갯수가 초과했습니다. 갯수를 줄여보세요 !!!"



let FILLOUT_INFO = "정보를 다시 입력해주세요"
let SENT_LINK = "링크가 전송되었습니다"
let CONFIRM_EMAIL = "이메일을 확인해주세요"





//LOGIN and SIGNUP ERROR
let MiMATCH_PASSWORD_ERROR = MiMATCH_PASSWORD + "\n다시 한번 확인해주세요"
let NO_ACCOUNT = "계정이 존재하지 않거나 \n삭제된 이메일 계정입니다. \n다시 한번 확인해주세요"


let IMAGE_LOGO = "logo"
let IMAGE_USER_PLACEHOLDER = "user-placeholder"
let IMAGE_PHOTO = "plus.circle"



let GRADIENT_COLORS = [
LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9647058824, green: 0.8274509804, blue: 0.3960784314, alpha: 1)), Color(#colorLiteral(red: 0.9921568627, green: 0.6274509804, blue: 0.5215686275, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing),
LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3215686275, green: 0.4352941176, blue: 0.9490196078, alpha: 1)), Color(#colorLiteral(red: 0.462745098, green: 0.2941176471, blue: 0.6352941176, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing),
LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9411764706, green: 0.5764705882, blue: 0.9843137255, alpha: 1)), Color(#colorLiteral(red: 0.9607843137, green: 0.3411764706, blue: 0.4235294118, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing),
LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5254901961, green: 0.5607843137, blue: 0.5882352941, alpha: 1)), Color(#colorLiteral(red: 0.3490196078, green: 0.3803921569, blue: 0.3921568627, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing),
LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3215686275, green: 0.4352941176, blue: 0.9490196078, alpha: 1)), Color(#colorLiteral(red: 0.4732982204, green: 0.5873056538, blue: 0.9990956398, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing),
LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9607843137, green: 0.968627451, blue: 0.9803921569, alpha: 1)), Color(#colorLiteral(red: 0.7647058824, green: 0.8117647059, blue: 0.8862745098, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing),
LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9019607843, green: 0.9137254902, blue: 0.9411764706, alpha: 1)), Color(#colorLiteral(red: 0.9333333333, green: 0.9450980392, blue: 0.9607843137, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)


]

let APP_THEME_GRADIENT = LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3215686275, green: 0.4352941176, blue: 0.9490196078, alpha: 1)), Color(#colorLiteral(red: 0.462745098, green: 0.2941176471, blue: 0.6352941176, alpha: 1))]), startPoint: .top , endPoint: .bottom)

    


//CARD VIEW

public let NO_NEW_CARD = "새로운 카드가 없습니다. \n잠시 후에 다시 접속해주세요"
public let NO_CONNECTION = "인터넷 접속이 원활하지 않습니다"


// FOOTER VIEW
public let BUTTONNAME_AFTER_VOTE  = "카드 다시 보기"

//FLAG

public let BLOCKUSER = "신고해주셔서 감사합니다"
public let BLOCKMSG = "끌림팀에서 검토 후 신속히 처리하겠습니다."

public let BLOCK_BUTTON = " 신고하기"
public let CACEL_BLOCK_BUTTON = "취소"
public let FLAGPICTURE_TITLE = "사진을 신고합니다"
public var data = ["혐오 또는 음란한 사진","개인정보 노출","욕설이 담긴 사진", "선정적인 사진"]
public let FLAG_USER_CHAT = "사용자 차단 및 신고하기"
public var chat_flag_option = ["혐오 또는 음란한 사진","개인정보 노출","욕설이 담긴 사진", "선정적인 사진","부적절한 대화내용"]


//Vote



//Expanded View
public let VOTE_SUBMIT_BUTTON = "투표 결과 확인하기"
public let RATING_TEXT = "이미지 호감도"
public let USER_RESULT = " 님의 실시간 첫인상 투표 결과"
public let NOVOTEIMAGE = "내 첫인상 투표 사진을 올려야 다른 회원이 \n나를 볼 수 있어요~ \n또는 이성과 연결이 되고 싶다면 \n평가 사진 올리기를 먼저 해주세요~"
public let PLEASE_UPLOAD_PIC = "사진을 먼저 등록해주세요"


//RatingDetailView

public let VOTENUM = "투표수 "
public let LIKENUM = "좋아요수 "
public let POINTNUM = "코인수"


public let VOTE_TIMESTAMP = "업로드된 날짜: "
public let GENDER = "성별:"


//Chart

public let SERIES_TITLE = "나의 OOTD(%)"

//Menu

public let PROFILE_VIEW = "내 프로파일 보기"
public let PROFILE_COMPLETE = "% 완료"
public let ACCOUNT = "계정"
public let PROFILE = "내 계정"
public let BILLING = "포인트 충전"
public let LOGIN = "로그인"
public let LOGOUT = "로그아웃"

//public let NOVOTEIMAGE2 = "내 첫인상 투표사진을 올려야 남들이 나를 볼 수 있어요~ \n이성과 연결이 되고 싶다면 평가 사진 올리기를 먼저 해주세요~"



// Upload  picture

public let PHOTOUPLOAD = "평가받고 싶은 사진 올리기"
public let SELECT_ATTRIBUTES = "사진에 대한 3가지 태그를 정해주세요"
public let UPLOAD_COMPLETE = "사진등록이 완료되었습니다"
public let UPLOAD_BUTTON = "등록"
public let ADD_TAG = "태그 추가"
public let PLEASE_ADD_TAG = "사진에 대한 태그를 입력해 주세요(3개이상)"


// Key

public var TOKEN : String = ""

//CHAT
//public let SEND_LIKE_MESSAGE = "안녕하세요 " + User.currentUser()!.username + "님께서 관심을 표현하였습니다."
public let MESSAGEVIEW_TITLE = "채팅"







//Notification

public let ACTIVITY = "알림"
public let LIKED_MESSAGE = "님이 끌림을 주셧습니다"
public let MATCHED_MESSAGE = "축하해요~. \n채팅창에서 서로 인사해보세요 ^^"
public let NOTIFICATION_HEADER = "최근 일주일 이내 내역이 보관됩니다"
public let CHAT_LIMIT_NOTIFICATION = "메세지 수는 30번으로 제한되어 있습니다"
public let CONGRAT_MATCHED = "축하합니다~ 반갑게 인사로 대화를 이어가보세요"

public let WELCOME_GLEEM = "가입을 축하드려요 \n사진을 올려서 내 첫인상을 실시간으로 확인해보세요"
public let REJECT_VOTE_IMAGE = "올리신 투표사진이\n승인에 실패하였습니다."


//Chat View

public let TYPE_MESSAGE = "메세지를 입력해주세요"
public let LEAVE_ROOM =  "채팅방 나가기"
public let END_CHAT =  "님과의 대화를 종료합니다"
public let NO_MATCHED_USER = "연결된 상대방이 없습니다"

//Favorite

public let SOMEONE_LIKED = "나에게 끌림을 준 카드"
public let I_LIKED = "내가 끌림을 준 카드"
public let MATCHING_CHECK_CURRENT_POINT = "상대방에게 채팅을 요청하면 10포인트가 소모됩니다"
public let NOT_ENOUGH_POINT = "가지고 계신 포인트가 부족합니다. \n필요한 포인트: " + String(POINT_USE) + "\n현재 가진 포인트: "
public let INFO_FAVORITE = "내가 관심있는 OOTD 카드들"
//public let CURRENT_PLACE = "상대방 거주지: "


//Stat

public let MY_STAT_RADAR = "나의 스타일 실시간 투표결과(%)"
public let VOTENUM_SOFAR = "받은 투표수"
public let RECENT_VOTE = "최근 나를 투표한 이성"
public let NO_VOTED_USER = "아직 투표한 유저가 없습니다"

public let NEW_UPLOAD = "(새로운 첫인상 투표 사진 업로드는 왼쪽 프로필사진을 눌러주세요)"
public let NEW_UPLOAD2 = "(참여하는 투표 사진이 없어요. \n왼쪽 프로필사진을 눌러서 참여해주세요)"


public let NO_DATA = "투표 받은 데이터가 없음"
//public let I_LIKED = "내가 호감있는 카드"



//HistoryView

public let NUM_HISTORIC_DATA = "투표가 종료된 사진들 - "

//PROFILEVIEW

public let NUM_MATCHED = "매칭된 횟수: "
public let NUM_SKIPPED = "넘긴 카드 개수: "
public let NUM_FLAGGED = "신고한 카드 개수: "

public let NUM_I_VOTED = "내가 투표한 카드 개수: "
public let NUM_GLEEM_POINT = "현재 보유한 Gleem 포인트: "
public let MY_AGE = "나이: "

class Ref {
    // Storage
    static var STORAGE_ROOT = Storage.storage().reference(forURL: "gs://blackcow-demo-d92d9.appspot.com")
    
    // Storage - Posts
    static var STORAGE_POSTS = STORAGE_ROOT.child("posts")
    static func STORAGE_POST_ID(postId: String) -> StorageReference {
        return STORAGE_POSTS.child(postId)
    }
    
    // Storage - Chat
    static var STORAGE_CHAT = STORAGE_ROOT.child("chat")
    static func STORAGE_CHAT_ID(chatId: String) -> StorageReference {
        return STORAGE_CHAT.child(chatId)
    }
    
    
    // Firestore
    static var FIRESTORE_ROOT = Firestore.firestore()
    
    // Firestore - Users
    static var FIRESTORE_COLLECTION_USERS = FIRESTORE_ROOT.collection("users")
    static func FIRESTORE_DOCUMENT_USERID(userId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_USERS.document(userId)
    }
    
    // Firestore - Location
    static var FIRESTORE_COLLECTION_USERS_LOCATION = FIRESTORE_ROOT.collection("user_location")
    static func FIRESTORE_DOCUMENT_USER_LOCATION(userId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_USERS_LOCATION.document(userId)
    }
    
    
    static var FIRESTORE_COLLECTION_TIMELINE = FIRESTORE_ROOT.collection("timeline")
    static func FIRESTORE_TIMELINE_DOCUMENT_USERID(userId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_TIMELINE.document(userId)
    }
    
    static var FIRESTORE_COLLECTION_ALL_POSTS = FIRESTORE_ROOT.collection("all_posts")
    
    
    static var FIRESTORE_COLLECTION_CHAT = FIRESTORE_ROOT.collection("chat")
    static func FIRESTORE_COLLECTION_CHATROOM(senderId: String, recipientId: String) -> CollectionReference {
        return FIRESTORE_COLLECTION_CHAT.document(senderId).collection("chatRoom").document(recipientId).collection("chatItems")
    }
    static var FIRESTORE_COLLECTION_INBOX_MESSAGES = FIRESTORE_ROOT.collection("messages")
    static func FIRESTORE_COLLECTION_INBOX_MESSAGES(userId: String) -> CollectionReference {
        return FIRESTORE_COLLECTION_INBOX_MESSAGES.document(userId).collection("inboxMessages")
    }
    
    static func FIRESTORE_COLLECTION_INBOX_MESSAGES_DOCUMENT_USERID(senderId: String, recipientId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_INBOX_MESSAGES.document(senderId).collection("inboxMessages").document(recipientId)
    }
    
    
    
    
    
    static var FIRESTORE_COLLECTION_FOLLOWING = FIRESTORE_ROOT.collection("following")
    static func FIRESTORE_COLLECTION_FOLLOWING_USERID(userId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_FOLLOWING.document(Auth.auth().currentUser!.uid).collection("userFollowing").document(userId)
    }
    static func FIRESTORE_COLLECTION_FOLLOWING(userId: String) -> CollectionReference {
        return FIRESTORE_COLLECTION_FOLLOWING.document(userId).collection("userFollowing")
    }
    
    
    
    
    static var FIRESTORE_COLLECTION_FOLLOWERS = FIRESTORE_ROOT.collection("followers")
    static func FIRESTORE_COLLECTION_FOLLOWERS_USERID(userId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_FOLLOWERS.document(userId).collection("userFollowers").document(Auth.auth().currentUser!.uid)
    }
    static func FIRESTORE_COLLECTION_FOLLOWERS(userId: String) -> CollectionReference {
        return FIRESTORE_COLLECTION_FOLLOWERS.document(userId).collection("userFollowers")
    }
    
    
    // Storage - Avatar
    static var STORAGE_AVATAR = STORAGE_ROOT.child("avatar")
    static func STORAGE_AVATAR_USERID(userId: String) -> StorageReference {
        return STORAGE_AVATAR.child(userId)
    }
    
    static var STORAGE_VOTE_PIC = STORAGE_ROOT.child("votepictures")
    static func STORAGE_VOTE_PIC_USERID(userId: String) -> StorageReference {
        return STORAGE_VOTE_PIC.child(userId)
    }
    
    
    static var FIRESTORE_COLLECTION_VOTE = FIRESTORE_ROOT.collection("vote")
    static func FIRESTORE_COLLECTION_VOTE_USERID(userId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_VOTE.document(userId)
    }
    
    
    
    static var FIRESTORE_COLLECTION_ACTIVE_VOTE = FIRESTORE_ROOT.collection("active_vote")
    static func FIRESTORE_COLLECTION_ACTIVE_VOTE_POSTID(postId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_ACTIVE_VOTE.document(postId)
    }
    
    static var FIRESTORE_COLLECTION_PENDING_VOTE = FIRESTORE_ROOT.collection("pending_vote")
    static func FIRESTORE_COLLECTION_PENDING_VOTE_USERID(userId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_PENDING_VOTE.document(userId)
    }
    
    static var FIRESTORE_COLLECTION_HISTORIC_VOTE_DATA = FIRESTORE_ROOT.collection("vote_image_history")
    static func FIRESTORE_COLLECTION_HISTORIC_VOTE_DATA_USERID(voteId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_HISTORIC_VOTE_DATA.document(User.currentUser()!.id).collection("past_vote").document(voteId)
    }
    
    
    static var FIRESTORE_COLLECTION_MYVOTE = FIRESTORE_ROOT.collection("myvote")
    static func FIRESTORE_COLLECTION_MYVOTE_USERID(postId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_MYVOTE.document(User.currentUser()!.id).collection("voted").document(postId)
    }
    
    static var FIRESTORE_COLLECTION_WHO_VOTED = FIRESTORE_ROOT.collection("Whodidvote")
    static func FIRESTORE_COLLECTION_WHO_VOTED_USERID(postId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_WHO_VOTED.document(postId).collection("voted").document(User.currentUser()!.id)
    }
    
    
    static var FIRESTORE_COLLECTION_ATTRIBUTE = FIRESTORE_ROOT.collection("Attributes")
    static func FIRESTORE_COLLECTION_ATTRIBUTE_GENDER(gender: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_VOTE.document(gender)
    }
    
    static func FIRESTORE_COLLECTION_ATTRIBUTE_FEMALE() -> DocumentReference {
        return FIRESTORE_COLLECTION_ATTRIBUTE.document("female")
    }
    
    static var FIRESTORE_COLLECTION_SOMEOME_LIKED = FIRESTORE_ROOT.collection("someone_liked")
    static func FIRESTORE_COLLECTION_SOMEOME_LIKED_USERID(userId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_SOMEOME_LIKED.document(userId)
    }
    
    
    static var FIRESTORE_COLLECTION_ACTIVITY = FIRESTORE_ROOT.collection("activity")
    static func FIRESTORE_COLLECTION_ACTIVITY_USERID(userId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_ACTIVITY.document(userId)
    }
    
    
    static var FIRESTORE_COLLECTION_LIKED = FIRESTORE_ROOT.collection("liked")
    static func FIRESTORE_COLLECTION_LIKED_POSTID(userId: String, postId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_LIKED.document(userId).collection("liked").document(postId)
    }
    
    
    static func FIRESTORE_GET_LIKED_USERID_COLLECTION(userId: String) -> CollectionReference {
        return FIRESTORE_COLLECTION_LIKED.document(userId).collection("liked")
    }
    
    
    
    static var FIRESTORE_COLLECTION_FLAG = FIRESTORE_ROOT.collection("flag")
    static func FIRESTORE_COLLECTION_FLAG_USERID(userId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_FLAG.document(userId)
    }
    
    
    
    static var FIRESTORE_COLLECTION_FLAG_CHAT = FIRESTORE_ROOT.collection("flag_from_chat")
    static func FIRESTORE_COLLECTION_FLAG_CHAT_USERID(userId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_FLAG_CHAT.document(userId)
    }
    
    
    static var FIRESTORE_COLLECTION_MATCH = FIRESTORE_ROOT.collection("matched")
    static func FIRESTORE_COLLECTION_MATCH_USERID(userId: String, userId2: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_MATCH.document(userId).collection("matched").document(userId2)
        
    }
    
    //    static func FIRESTORE_GET_VOTE() -> DocumentReference {
    //       return FIRESTORE_COLLECTION_VOTE.document(userId)
    //    }
}
