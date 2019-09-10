//
//  FluffViewFactory.swift
//  Runner
//
//  Created by wk on 10/9/2562 BE.
//  Copyright © 2562 The Chromium Authors. All rights reserved.
//

import Foundation



public class FluffViewFactory: NSObject, FlutterPlatformViewFactory {
    public func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
        ) -> FlutterPlatformView {
        
        return FluffView(frame, viewId: viewId, args: args)
    }
}

public class FluffView: NSObject, FlutterPlatformView {
    let frame: CGRect
    let viewId: Int64
    
    init(_ frame: CGRect, viewId: Int64, args: Any?) {
        self.frame = frame
        self.viewId = viewId
    }
    public func view() -> UIView {
        return UISlider(frame: frame)
    }
}
