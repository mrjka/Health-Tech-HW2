//
//  SpatialMemoryTask.swift
//  ADHD
//
//  Created by Jaldeep Acharya on 2017-03-12.
//  Copyright © 2017 Jaldeep Acharya. All rights reserved.
//

import Foundation
import ResearchKit

public var SpatialMemoryTask: ORKOrderedTask {
    return ORKOrderedTask.spatialSpanMemoryTask(withIdentifier: "SpatialMemoryTask", intendedUseDescription: "You will be given a sequence that you need to remember and then input it back", initialSpan: 4, minimumSpan: 1, maximumSpan: 6, playSpeed: 3, maximumTests: 4,maximumConsecutiveFailures: 10, customTargetImage: nil, customTargetPluralName
        : "flowers", requireReversal: false, options: ORKPredefinedTaskOption())
}
