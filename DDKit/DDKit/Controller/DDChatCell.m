//
// Created by Ayasofya on 16/1/8.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import "DDChatCell.h"

@interface DDChatCell()

@property (nonatomic, strong) UILabel *contentLbl;

@end

@implementation DDChatCell {

}

- (UITableViewCell *)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.contentLbl = [UILabel new];
        [self.contentView addSubview:self.contentLbl];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentLbl.frame = self.contentView.frame;
}

- (void)updateCell:(NSString *)content {
    self.contentLbl.text = content;
}
@end