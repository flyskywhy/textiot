import { API } from '../core/api'
import { streamHandler } from '../helpers/handlers'
import { FeedItem, Block } from '../models'
import { ReadableStream } from 'web-streams-polyfill/ponyfill'

/**
 * Subscribe is an API to stream updates from a thread or all threads
 *
 * @extends API
 */
export default class Subscribe extends API {
  /**
   * Subscribe to updates in a thread or all threads
   * An update is generated when a new block is added to a thread. See [[Block.BlockType]] for
   * details and a list of block types to which you can subscribe.
   *
   * @param types List of event types to stream (e.g., ['FILES', 'COMMENTS', 'LIKES']. Leave
   * undefined or empty to include all types.
   * @param thread Limit updates to a single thread. Leave undefined or an empty stream to
   * stream events across all threads.
   * @returns A ReadableStream of FeedItem objects.
   */
  async stream(types?: Block.BlockType[], thread?: string) {
    const response = await this.sendGet(`sub${thread ? `/${thread}` : ''}`, undefined, {
      type: (types || []).join('|')
     })
    if (!response.body) {
      throw Error('Empty response stream')
    }
    return streamHandler<FeedItem>(response.body as ReadableStream)
  }
}
