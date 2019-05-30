import Foundation

class EpisodeCounter {

  var counter = Array<Int>()

  func countForSeason(number: Int) -> Int {
    return counter[number]
  }

  func increaseForSeason(number: Int) {
    counter[number] += 1
  }

  func decreaseForSeason(number: Int) {
    counter[number] -= 1
  }
}
