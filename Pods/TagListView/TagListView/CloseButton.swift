//
//  CloseButton.swift
//  TagListViewDemo
//
//  Created by Benjamin Wu on 2/11/16.
//  Copyright © 2016 Ela. All rights reserved.
//

import UIKit

internal class CloseButton: UIButton {

    var iconSize: CGFloat = 10
    var lineWidth: CGFloat = 1
    var lineColor: UIColor = UIColor.white.withAlphaComponent(0.54)

    weak var tagView: TagView?

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()

        path.lineWidth = lineWidth
        path.lineCapStyle = .butt

        let iconFrame = CGRect(
            x: (rect.width - iconSize) / 2.0,
            y: (rect.height - iconSize) / 2.0,
            width: iconSize,
            height: iconSize
        )
        
        print("rect height: ",rect.height)
               print("rect width: ",rect.width)
               print("iconFrame width: ",iconFrame.width)
               print("iconFrame height: ",iconFrame.height)
               print("iconFrame maxX/2: ",iconFrame.maxX/2)
               print("iconFrame maxY/2: ",iconFrame.maxY/2)
               print("iconFrame minX:/2 ",iconFrame.minX/2)
               print("iconFrame minY/2: ",iconFrame.minY/2)
                print("iconFrame midX: ",iconFrame.midX)
                print("iconFrame midY: ",iconFrame.midY)
               print("iconFrame origin: ",iconFrame.origin)
        
        path.move(to: iconFrame.origin)
        path.move(to: CGPoint(x: iconFrame.minX+3, y: iconFrame.maxY+1))
        path.addLine(to: CGPoint(x: iconFrame.minX, y: iconFrame.midY))
        path.move(to: CGPoint(x: iconFrame.minX+3, y: iconFrame.maxY+1))
        path.addLine(to: CGPoint(x: iconFrame.maxX, y: iconFrame.minY-3))
//        path.addLine(to: CGPoint(x: iconFrame.maxX, y: iconFrame.maxY))
//        path.move(to: CGPoint(x: iconFrame.maxX, y: iconFrame.minY))
//        path.addLine(to: CGPoint(x: iconFrame.minX, y: iconFrame.maxY))
        


        lineColor.setStroke()

        path.stroke()
    }

}
