// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>

@class EventPlainObject;
@class AnnouncementGalleryCellObjectFactory;

@interface AnnouncementGalleryDataDisplayManager : NSObject

- (instancetype)initWithCellObjectFactory:(AnnouncementGalleryCellObjectFactory *)cellObjectFactory;

/**
 @author Egor Tolstoy
 
 Returns a data source object for UICollectionView with events
 
 @param collectionView UICollectionView with events
 @param events         Future events
 
 @return Data source
 */
- (id<UICollectionViewDataSource>)dataSourceForCollectionView:(UICollectionView *)collectionView
                                                   withEvents:(NSArray <EventPlainObject *> *)events;

/**
 @author Egor Tolstoy
 
 Returns a delegate object for UICollectionView with events
 
 @param collectionView UICollectionView with events
 
 @return Delegate
 */
- (id<UICollectionViewDelegate>)delegateForCollectionView:(UICollectionView *)collectionView;

@end
