class ColorTheme {
  final String? uuid;
  final String? uniqueId;
  final String? themeName;
  final String? themeDescription;
  final String? bigGameCardTextColor; //text color on card(prize list, units, 'prizes' and 'available to win' headings)
  final String? bigGameCardPrimaryColor; //card bg color
  final String? bigGameCardSecondaryColor; //draw type container bg color and color for border surrounding the prize list and bg of countdown container
  final String? bigGameCardSecondaryTextColor; //draw type text color and color of countdown labels
  final String? bigGameCardCountDownColor;
  final String? bigGameCardTimeLeftColor; // 'time left to join the draw' text color
  final String? bigGameCardStatusBackgroundColor; //'0 of 1 won' container bg color
  final String? bigGameCardStatusTextColor; //'0 of 1 won' text color
  final dynamic entryStateMobileImage;
  final String? entryStateBackgroundColor; //bg color for game card on home screen
  final String? entryStateTextColor; // text color for card on home screen
  final String? entryStateButtonColor; //button bg color for card on home screen
  final String? entryStateButtonTextColor; //button text color for card on home screen
  final dynamic entryStateWebImage;
  final String? gameTicketBackgroundColor; //not in use
  final String? gameTicketIconColor; //ticket icon color
  final String? gameTicketHeaderBackgroundColor; //not in use
  final String? gameTicketHeaderTextColor; //ticket price color and ticket quantity count color
  final String? gameTicketButtonBackgroundColor; //ticket button bg color
  final String? gameTicketButtonTextColor; //ticket button text color
  final String? gameTicketOutlineColor; //ticket border color
  final String? gameTicketTagButtonColor; //'best value' container bg color and color for 'best value' icon
  final String? gameTicketTagTextColor; //'best value' container text color
  final String? gameTicketPrizeTextColor; //for price in the ticket container
  final String? gameTicketUnitColor; //for the ticket count in the ticket container
  final String? isActive;
  final String? isDefault;
  final dynamic createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ColorTheme({
    this.gameTicketPrizeTextColor,
    this.gameTicketUnitColor,
    this.uuid,
    this.uniqueId,
    this.themeName,
    this.themeDescription,
    this.bigGameCardTextColor,
    this.bigGameCardPrimaryColor,
    this.bigGameCardSecondaryColor,
    this.bigGameCardSecondaryTextColor,
    this.bigGameCardCountDownColor,
    this.bigGameCardTimeLeftColor,
    this.bigGameCardStatusBackgroundColor,
    this.bigGameCardStatusTextColor,
    this.entryStateMobileImage,
    this.entryStateBackgroundColor,
    this.entryStateTextColor,
    this.entryStateButtonColor,
    this.entryStateButtonTextColor,
    this.entryStateWebImage,
    this.gameTicketBackgroundColor,
    this.gameTicketIconColor,
    this.gameTicketHeaderBackgroundColor,
    this.gameTicketHeaderTextColor,
    this.gameTicketButtonBackgroundColor,
    this.gameTicketButtonTextColor,
    this.gameTicketOutlineColor,
    this.gameTicketTagButtonColor,
    this.gameTicketTagTextColor,
    this.isActive,
    this.isDefault,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory ColorTheme.fromJson(Map<String, dynamic> json) => ColorTheme(
    uuid: json["uuid"],
    uniqueId: json["uniqueID"],
    themeName: json["theme_name"],
    themeDescription: json["theme_description"],
    bigGameCardTextColor: json["big_game_card_text_color"],
    bigGameCardPrimaryColor: json["big_game_card_primary_color"],
    bigGameCardTimeLeftColor: json["big_game_card_time_left_color"],
    bigGameCardSecondaryColor: json["big_game_card_secondary_color"],
    bigGameCardSecondaryTextColor: json["big_game_card_secondary_text_color"],
    bigGameCardCountDownColor: json["big_game_card_count_down_color"],
    bigGameCardStatusBackgroundColor: json["big_game_card_status_background_color"],
    bigGameCardStatusTextColor: json["big_game_card_status_text_color"],
    entryStateMobileImage: json["entry_state_mobile_image"],
    entryStateBackgroundColor: json["entry_state_background_color"],
    entryStateTextColor: json["entry_state_text_color"],
    entryStateButtonColor: json["entry_state_button_color"],
    entryStateButtonTextColor: json["entry_state_button_text_color"],
    entryStateWebImage: json["entry_state_web_image"],
    gameTicketBackgroundColor: json["game_ticket_background_color"],
    gameTicketIconColor: json["game_ticket_icon_color"],
    gameTicketHeaderBackgroundColor: json["game_ticket_header_background_color"],
    gameTicketHeaderTextColor: json["game_ticket_header_text_color"],
    gameTicketButtonBackgroundColor: json["game_ticket_button_background_color"],
    gameTicketButtonTextColor: json["game_ticket_button_text_color"],
    gameTicketOutlineColor: json["game_ticket_outline_color"],
    gameTicketTagButtonColor: json["game_ticket_tag_button_color"],
    gameTicketTagTextColor: json["game_ticket_tag_text_color"],
    gameTicketPrizeTextColor: json["game_ticket_prize_text_color"],
    gameTicketUnitColor: json["game_ticket_unit_color"],
    isActive: json["is_active"],
    isDefault: json["is_default"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "game_ticket_unit_color": gameTicketUnitColor,
    "game_ticket_prize_text_color": gameTicketPrizeTextColor,
    "uuid": uuid,
    "uniqueID": uniqueId,
    "theme_name": themeName,
    "theme_description": themeDescription,
    "big_game_card_text_color": bigGameCardTextColor,
    "big_game_card_primary_color": bigGameCardPrimaryColor,
    "big_game_card_secondary_color": bigGameCardSecondaryColor,
    "big_game_card_time_left_color": bigGameCardTimeLeftColor,
    "big_game_card_secondary_text_color": bigGameCardSecondaryTextColor,
    "big_game_card_count_down_color": bigGameCardCountDownColor,
    "big_game_card_status_background_color": bigGameCardStatusBackgroundColor,
    "big_game_card_status_text_color": bigGameCardStatusTextColor,
    "entry_state_mobile_image": entryStateMobileImage,
    "entry_state_background_color": entryStateBackgroundColor,
    "entry_state_text_color": entryStateTextColor,
    "entry_state_button_color": entryStateButtonColor,
    "entry_state_button_text_color": entryStateButtonTextColor,
    "entry_state_web_image": entryStateWebImage,
    "game_ticket_background_color": gameTicketBackgroundColor,
    "game_ticket_icon_color": gameTicketIconColor,
    "game_ticket_header_background_color": gameTicketHeaderBackgroundColor,
    "game_ticket_header_text_color": gameTicketHeaderTextColor,
    "game_ticket_button_background_color": gameTicketButtonBackgroundColor,
    "game_ticket_button_text_color": gameTicketButtonTextColor,
    "game_ticket_outline_color": gameTicketOutlineColor,
    "game_ticket_tag_button_color": gameTicketTagButtonColor,
    "game_ticket_tag_text_color": gameTicketTagTextColor,
    "is_active": isActive,
    "is_default": isDefault,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}